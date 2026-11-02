package test;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import generateConstraints.ConstraintGenerator;
import testDataGen.GenerateDataSet;
import testDataGen.PopulateTestData;
import util.Configuration;
import util.MutationStat;
import util.Pair;
import util.Result;
import util.SingleMutationStat;
import util.TableMap;
import util.Utilities;

public class RegressionTests {

	String basePath;
	String schema;
	String sampleData;
	String queries;
	String mutants;
	String sampleDataJsonFilePath;
	String benchmarkName;
	String outputDir;

	public RegressionTests(String basePath, String schemaFile, String sampleDataFile, String query, String mutant,
			String sampleDataJsonFilePath, String benchmarkname, String outputDir) {
		super();
		this.basePath = basePath;
		this.schema = Utilities.readFile(new File(schemaFile));
		this.sampleData = Utilities.readFile(new File(sampleDataFile));
		this.sampleDataJsonFilePath = sampleDataJsonFilePath;
		this.queries = query;
		this.mutants = mutant;
		this.benchmarkName = benchmarkname.split(".sql")[0];
		this.outputDir = outputDir;
	}

	private Connection getTestConn() throws Exception {

		// added by rambabu
		String tempDatabaseType = Configuration.getProperty("tempDatabaseType");
		String loginUrl = "";
		Connection conn = null;

		// choosing connection based on database type
		if (tempDatabaseType.equalsIgnoreCase("postgresql")) {
			Class.forName("org.postgresql.Driver");

			loginUrl = "jdbc:postgresql://" + Configuration.getProperty("databaseIP") + ":"
					+ Configuration.getProperty("databasePort") + "/" + Configuration.getProperty("databaseName");
			conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
					Configuration.getProperty("testDatabaseUserPasswd"));
			;
		} else if (tempDatabaseType.equalsIgnoreCase("mysql")) {
			Class.forName("com.mysql.cj.jdbc.Driver");

			loginUrl = "jdbc:mysql://" + Configuration.getProperty("databaseIP") + ":"
					+ Configuration.getProperty("databasePort") + "/" + Configuration.getProperty("databaseName");
			conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
					Configuration.getProperty("testDatabaseUserPasswd"));
			;
		} else if (tempDatabaseType.equalsIgnoreCase("sqlite")) {
			Class.forName("org.sqlite.JDBC");
			File file = new File(Configuration.getProperty("homeDir") + Configuration.getProperty("databaseName"));
			// if (file.delete()) {
			// System.out.println("Database file has been deleted successfully.");
			// }
			file = new File(Configuration.getProperty("homeDir") + Configuration.getProperty("databaseName") + "-shm");
			// if (file.delete()) {
			// System.out.println("Database file shm has been deleted successfully.");
			// }
			file = new File(Configuration.getProperty("homeDir") + Configuration.getProperty("databaseName") + "-wal");
			// if (file.delete()) {
			// System.out.println("Database file wal has been deleted successfully.");
			// }
			loginUrl = "jdbc:sqlite" + ":" + Configuration.getProperty("homeDir")
					+ Configuration.getProperty("databaseName");

			conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
					Configuration.getProperty("testDatabaseUserPasswd"));
			String query = "PRAGMA journal_mode=WAL;";
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(query);
			stmt.close();
		}
		return conn;
	}

	/**
	 * Load queries from the queries.txt file
	 * 
	 * @return Map of queryId,query
	 * @throws IOException
	 */
	private Map<Integer, Pair<String, String>> getQueries() throws IOException {
		Map<Integer, Pair<String, String>> queryMap = new HashMap<Integer, Pair<String, String>>();

		// String
		// fullPath=Configuration.getProperty("testDir")+"/universityTest/queries.txt";
		// String fullPath = Configuration.getProperty("testDir") +
		// "/universityTest/queriesnew.txt";
		// String
		// fullPath=Configuration.getProperty("testDir")+"/universityTest/tempqueries.txt";
		// String
		// fullPath=Configuration.getProperty("testDir")+"/universityTest/subsetbtpque.txt";
		String fullPath = this.queries;

		FileReader fileReader = new FileReader(new File(fullPath));
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			if (line.trim().startsWith("--"))
				continue;
			// The queries file contains entries for queries in the format id|query
			String[] lineArr = line.split("\\|", 3);
			if (lineArr.length < 2)
				continue;
			if (lineArr[1] == null || lineArr[1].trim().equals(""))
				continue;
			Integer queryId = 0;

			try {
				queryId = Integer.parseInt(lineArr[0].trim());
			} catch (NumberFormatException nfe) {
				continue;
			}
			// lineArr = lineArr[1].split("\\|", 2);
			if (Configuration.getProperty("tempDatabaseType").equalsIgnoreCase("sqlite")) {
				lineArr[1] = GenerateDataSet.convertBackticksToSingleQuotes(lineArr[1]);
			}
			// List<Pair<String, String>> queryList = new ArrayList<Pair<String, String>>();

			Pair p = new Pair<>();
			p.setFirst(lineArr[1]);
			p.setSecond(lineArr[2]);

			// queryList.add(p);
			queryMap.put(queryId, p);
		}
		fileReader.close();

		return queryMap;
	}

	/**
	 * Gets mutants from the mutants.txt file
	 * 
	 * @return map of queryId, list of mutants
	 * @throws IOException
	 */
	private Map<Integer, List<Pair<String, String>>> getMutants() throws IOException {
		Map<Integer, List<Pair<String, String>>> mutantMap = new HashMap<Integer, List<Pair<String, String>>>();

		// String fullPath=Configuration.getProperty("testDir")+"/universityTest/" +
		// "mutants.txt";
		//
		// +

		// String fullPath = Configuration.getProperty("testDir") + "/universityTest/" +
		// "mutantsnew.txt";
		// String fullPath=Configuration.getProperty("testDir")+"/universityTest/" +
		// "tempmutants.txt";
		// String fullPath=Configuration.getProperty("testDir")+"/universityTest/" +
		// "subsetbtpmut.txt";
		String fullPath = this.mutants;

		FileReader fileReader = new FileReader(new File(fullPath));
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			if (line.trim().startsWith("--"))
				continue;
			// The mutants file contains entries for queries in the format id|query. The id
			// should match the query
			String[] lineArr = line.split("\\|", 3);
			if (lineArr.length < 3)
				continue;
			if (lineArr[2] == null || lineArr[1].trim().equals(""))
				continue;
			Integer queryId = 0;
			try {
				queryId = Integer.parseInt(lineArr[0].trim());
			} catch (NumberFormatException nfe) {
				continue;
			}
			List<Pair<String, String>> mutantList = mutantMap.get(queryId);
			if (mutantList == null) {
				mutantList = new ArrayList<Pair<String, String>>();
			}
			// if(Configuration.getProperty("tempDatabaseType").equalsIgnoreCase("sqlite")){
			// lineArr[1] = GenerateDataSet.convertBackticksToSingleQuotes(lineArr[1]);
			// }
			Pair p = new Pair<>();
			p.setFirst(lineArr[1]);
			p.setSecond(lineArr[2]);
			mutantList.add(p);
			mutantMap.put(queryId, mutantList);
		}
		fileReader.close();

		return mutantMap;
	}

	private Result generateDataSets(double queryId, String query) {

		try (Connection conn = getTestConn()) {
			boolean orderDependent = false;
			String tempFilePath = File.separator + queryId;
			GenerateDataSet d = new GenerateDataSet();
			Result res = d.generateDatasetForQuery(conn, queryId, query, schema, sampleData,
					sampleDataJsonFilePath, orderDependent, tempFilePath, null);

			return res;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * Tests if the basic dataset produces a non-empty result
	 * 
	 * @param queryId queryId of the dataset
	 * @param query   query
	 * @return
	 */
	private boolean testBasicDataset(double queryId, String query) {

		try (Connection testConn = getTestConn()) {
			String filePath = queryId + "";

			PopulateTestData.deleteAllTablesFromTestUser(testConn);
			GenerateDataSet.loadSchema(testConn, schema);
			GenerateDataSet.loadSampleData(testConn, sampleData);

			TableMap tableMap = TableMap.getInstances(testConn, 1);
			// System.out.println("Testing BASIC Dataset
			// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			// PopulateTestData.loadCopyFileToDataBase(testConn, "DS0", filePath, tableMap);
			PopulateTestData.loadSQLFilesToDataBase(testConn, "DS0.sql", filePath);

			PreparedStatement ptsmt = testConn.prepareStatement(query);
			ResultSet rs = ptsmt.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			// e.printStackTrace();
		}
		return false;
	}

	private boolean testMutantKilling(double queryId, List<String> datasets, String query, String mutant) {

		for (String datasetId : datasets) {
			try (Connection testConn = getTestConn()) {
				String filePath = queryId + "";

				GenerateDataSet.convertBackticksToSingleQuotes(mutant); // added to remove backticks

				GenerateDataSet.loadSchema(testConn, schema);
				GenerateDataSet.loadSampleData(testConn, sampleData);

				TableMap tableMap = TableMap.getInstances(testConn, 1);
				// PopulateTestData.loadCopyFileToDataBase(testConn, datasetId, filePath,
				// tableMap);
				// PopulateTestData.loadSQLFilesToDataBase(testConn, datasetId+".sql",
				// filePath);
				PopulateTestData.loadSQLFilesToDataBase(testConn, datasetId, filePath);

				// String testQuery= "with q as ("+query+") , m as("+mutant+") (select * from q
				// EXCEPT ALL m) UNION ALL (select * from m EXCEPT ALL q)";

				String testQuery = "((" + query + ") EXCEPT ALL (" + mutant + ")) "
						+ "UNION ((" + mutant + ") EXCEPT ALL (" + query + "))";

				try (PreparedStatement ptsmt = testConn.prepareStatement(testQuery);
						ResultSet rs = ptsmt.executeQuery()) {


					if (rs.next()) {
						System.out.println("**********" + queryId + " killed by " + datasetId + "**********");
						return true;
					}
				}
			} catch (SQLException e) {
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	private boolean testOnSampleData(double queryId, String query, String mutant){
		try (Connection testConn = getTestConn()) {
				GenerateDataSet.convertBackticksToSingleQuotes(mutant); // added to remove backticks

				GenerateDataSet.loadSchema(testConn, schema);
				GenerateDataSet.loadSampleData(testConn, sampleData);
				String testQuery = "((" + query + ") EXCEPT ALL (" + mutant + ")) "
						+ "UNION ((" + mutant + ") EXCEPT ALL (" + query + "))";

				try (PreparedStatement ptsmt = testConn.prepareStatement(testQuery);
						ResultSet rs = ptsmt.executeQuery()) {

					if (rs.next()) {
						return false;
					}
				}
			} catch (SQLException e) {
				String sqlState = e.getSQLState();

				// Number of columns don't match
				if ("42611".equals(sqlState)) {
					return true;
				}

				// Datatype mismatch
				if ("42804".equals(sqlState)) {
					return true;
				}

				// Other SQL errors
				e.printStackTrace();
				return false;
			} catch (Exception e) {
				e.printStackTrace();
			}
		return false;
	}
	public List<String> getDatasets(String folderPath) {

		// String folderPath = "/path/to/your/folder"; // replace with your folder path
		List<String> datasets = new ArrayList<String>();

		File folder = new File(folderPath);
		for (File subFolder : folder.listFiles()) {
			if (subFolder.isDirectory() && subFolder.getName().matches("DS\\d+")) {
				datasets.add(subFolder.getName());
			}
		}
		return datasets;
	}
	/**
	 * Helper to split a string into lines of a maximum length.
	 */
	private static List<String> wrapText(String text, int width) {
		List<String> lines = new ArrayList<>();
		if (text == null || text.isEmpty()) {
			lines.add("");
			return lines;
		}
		for (int i = 0; i < text.length(); i += width) {
			lines.add(text.substring(i, Math.min(text.length(), i + width)));
		}
		return lines;
	}

	public static String formatTableRow(double id, String q1, String q2, String isEq, long time,String result) {
		int wID = 8, wQ1 = 40, wQ2 = 40, wEq = 15, wTime = 10,wResult=15;
		List<String> q1Lines = wrapText(q1, wQ1);
		List<String> q2Lines = wrapText(q2, wQ2);
		int maxLines = Math.max(q1Lines.size(), q2Lines.size());
		StringBuilder sb = new StringBuilder();
		String formatStr = " %-" + wID + "s | %-" + wQ1 + "s | %-" + wQ2 + "s | %-" + wEq+ "s | %-" + wResult + "s | %-" + wTime + "s%n";
		sb.append(String.format(formatStr, Double.toString(id), q1Lines.get(0), q2Lines.get(0), isEq,result,
				Long.toString(time)));
		for (int i = 1; i < maxLines; i++) {
			String currentQ1 = (i < q1Lines.size()) ? q1Lines.get(i) : "";
			String currentQ2 = (i < q2Lines.size()) ? q2Lines.get(i) : "";
			sb.append(String.format(formatStr, "", currentQ1, currentQ2, "", "",""));
		}
		String sep = "=";
		sb.append(sep.repeat(142));

		return sb.toString();
	}
	private void print(HashMap<String, Integer> hash,String type,String color) {

		System.out.println(color + "\n" + "=".repeat(50));
		System.out.println(type);
		System.out.println("=".repeat(50) + "\u001B[0m");

		if (hash == null || hash.isEmpty()) {
			System.out.println("None");
			return;
		}

		for (Map.Entry<String, Integer> entry : hash.entrySet()) {
			System.out.printf(color + "%-25s : %d%n\u001B[0m",entry.getKey(),entry.getValue());
		}
	}
	public Map<Integer, List<String>> runRegressionTestForEquivalence() {
		Map<Integer, List<String>> testResult = new LinkedHashMap<Integer, List<String>>();
		Map<Integer, Pair<String, String>> queryMap;
		Map<Integer, List<Pair<String, String>>> mutantMap;
		try {
			queryMap = getQueries();
			mutantMap = getMutants();
		} catch (Exception e) {
			System.out.println("Error reading queries or mutants");
			e.printStackTrace();
			return null;
		}
		int failed = 0, unsupported = 0, totalTime = 0, invalidDataSet = 0,totalQueries=0, timeout=0,equivalent=0,nonEquivalent=0,dataGenerated=0;
		String eqOutFile = Configuration.getProperty("homeDir") + "/equivalenceResults.txt";
		String headerLine = String.format(" %-8s | %-40s | %-40s | %-15s | %-12s | %-10s",
				"QueryID", "First Query", "Second Query", "IsEquivalent","Status", "Time Taken");
		String separator = "=";

		Utilities.writeFile(eqOutFile, headerLine, false);
		Utilities.writeFile(eqOutFile, separator.repeat(142), true);
		HashMap<String,Integer>queryTypeIncorrectData=new HashMap<>();
		HashMap<String,Integer>queryTypeTimeOut=new HashMap<>();
		HashMap<String,Integer>queryTypeException=new HashMap<>();
		for (Integer queryId : queryMap.keySet()) {
			System.out.println("\u001B[31m"+separator.repeat(50)+"\u001B[0m");
			System.out.println("Test query "+queryId);
			System.out.println("\u001B[31m"+separator.repeat(50)+"\u001B[0m");
			List<String> errors = new ArrayList<>();
			Pair<String, String> pq = queryMap.get(queryId);
			String queryType = pq.getFirst(), query = pq.getSecond();
			List<String> dataset = new ArrayList<>();
			query = query.replaceAll(";", "");
			double j=1;
			if(!mutantMap.containsKey(queryId)) continue;
			
			for (Pair<String, String> p : mutantMap.get(queryId)) {
				String stats="";
				Result res = new Result();
				String mutant = p.getSecond().replaceAll(";", "");
					
				String symQuery="("+query + ") except (" + mutant+")";
				double newQueryId=queryId;
				newQueryId+=(j/100);
				j++;
				try {
					
					System.out.println("\u001B[34m"+separator.repeat(50)+"\u001B[0m");
					System.out.println(newQueryId+") "+symQuery);  
									
					res = generateDataSets(newQueryId, symQuery);
					long timeTaken = (res == null) ? -1 : res.getTimeTaken();
					if(res==null || res.getResult()==null){
						Boolean isKilled = testOnSampleData(newQueryId,query,mutant);
						if(isKilled){
							stats+=formatTableRow(newQueryId, query, mutant, "No", timeTaken,"Incompatible");
							nonEquivalent++;
						}else{
							errors.add("Exception for following query: " + symQuery);
							stats+=formatTableRow(newQueryId, query, mutant, "Error", timeTaken,"Exception");
							unsupported++;
							queryTypeException.put(queryType, queryTypeException.getOrDefault(queryType, 0)+1);
							
						}
						
					}
					else if(res.getDatasetCount()>0){
						Boolean isKilled = testMutantKilling(newQueryId,res.getDatasets(),query,mutant);
						if(isKilled){
								stats+=formatTableRow(newQueryId, query, mutant, "No", timeTaken,res.getResult());
								nonEquivalent++;
								dataGenerated++;
								totalTime+=timeTaken;
							}
						else{
							errors.add("Unable to prove Non-equivalence: " + mutants);
							stats+=formatTableRow(newQueryId, query, mutant, "Unkown", timeTaken,"INVALID");
							invalidDataSet++;
							queryTypeIncorrectData.put(queryType,queryTypeIncorrectData.getOrDefault(queryType, 0)+1);
						}
						
					}else{
						
						if(res.getResult().equals("UNSATISFIABLE")){
							stats+=formatTableRow(newQueryId, query, mutant, "Yes", timeTaken,res.getResult());
							equivalent++;
						}
						else{
							timeout++;
							stats+=formatTableRow(newQueryId, query, mutant, "Unkown", timeTaken,"TIMEOUT");
							queryTypeTimeOut.put(queryType, queryTypeTimeOut.getOrDefault(queryType, 0)+1);

						}
					}
					
				} catch (Exception e) {
					unsupported++;
					stats+=formatTableRow(newQueryId, query, mutant, "Error", -1 ,"Exception");
					errors.add("Exception in killing mutant query: "+ mutants);
					queryTypeException.put(queryType, queryTypeException.getOrDefault(queryType, 0)+1);
				}
				totalQueries++;
				Utilities.writeFile(eqOutFile, stats,true);
			}
			testResult.put(queryId, errors);
		}
		
		// Blue (\u001B[34m)
		System.out.println("\u001B[34m\n" + "=".repeat(50));
		System.out.println("                EXECUTION SUMMARY                ");
		System.out.println("=".repeat(50) + "\u001B[0m");

		//Cyan for Total, Green for Passed, Red for Failures
		System.out.printf("\u001B[36m%-35s : %d\u001B[0m%n", "Total Queries Processed", totalQueries);
		System.out.printf("\u001B[32m%-35s : %d\u001B[0m%n", "Queries Not Equivalent", nonEquivalent);
		System.out.printf("\u001B[32m%-35s : %d\u001B[0m%n", "Queries Equivalent", equivalent);
		System.out.printf("\u001B[31m%-35s : %d\u001B[0m%n", "Invalid Dataset generated", invalidDataSet);
		System.out.printf("\u001B[31m%-35s : %d\u001B[0m%n", "Unsupported (Dataset Generation Errors)", unsupported);

		//Blue (\u001B[34m)
		System.out.println("\u001B[34m" + "-".repeat(50));
		System.out.printf("%-35s : %d %n", "Timeouts", timeout);
		System.out.printf("%-35s : %d ms%n", "Total Execution Time", totalTime);
		long avgDataGenTime = (dataGenerated > 0) ? totalTime / dataGenerated : 0;
		System.out.printf("%-35s : %d ms%n", "Time Per Query", avgDataGenTime);
		System.out.println("=".repeat(50) + "\u001B[0m");

		print(queryTypeException, "Query Types Giving Exception","\u001B[95m");
		print(queryTypeIncorrectData, "Incorrect Dataset Generated For Following Types","\u001B[93m");
		print(queryTypeTimeOut, "Query Types Giving Time Out","\u001B[96m");

		System.out.println("\n" + "=".repeat(50));
		return testResult;
	}

	public Map<Integer, List<String>> runRegressionTests() {

		Map<Integer, Pair<String, String>> queryMap;
		Map<Integer, List<Pair<String, String>>> mutantMap;

		Map<Integer, List<String>> testResult = new LinkedHashMap<Integer, List<String>>();

		try {
			queryMap = getQueries();
			mutantMap = getMutants();
			// System.out.println(queryMap);
		} catch (Exception e) {
			System.out.println("Error reading queries or mutants");
			e.printStackTrace();
			return null;
		}
		int failed = 0;
		int total = 0;
		int basicfail = 0;
		int unsupported = 0;
		MutationStat mutationStat = new MutationStat();
		MutationStat queryStat = new MutationStat();
		String myregout = Configuration.getProperty("homeDir") + "/myregout.txt";
		String failedpairs = this.outputDir + "/" + this.benchmarkName + "-mutant-results.out";

		Utilities.writeFile(failedpairs, "", false);
		Utilities.writeFile(myregout, "", false);

		for (double queryId : queryMap.keySet()) {
			String failedmutants = "";
			List<String> errors = new ArrayList<String>();
			long startTime = System.currentTimeMillis();
			int qId=(int)Math.round(queryId);
			Pair<String, String> pq = queryMap.get(qId);
			String query = pq.getSecond();
			String queryType = pq.getFirst();
			// System.out.println(query);
			List<String> datasets = new ArrayList<>();
			Result res = new Result();
			int totalperq = 0, failperq = 0, basic = 0, unsup = 0;
			// Generate datasets

			boolean runTestsOnSampleData = false; // set false for normal regression test
			if (runTestsOnSampleData && mutantMap.containsKey(qId)) {
				Set<String> mutantSet = new HashSet<>();
				int setquery = 0;
				for (Pair<String, String> p : mutantMap.get(qId)) {
					String mutantType = p.getFirst();
					String mutant = p.getSecond();
					int flag = 0;
					// total++;
					totalperq++;
					try {
						if (testSampleDataset(query, mutant) == false) {
							errors.add("\t" + mutant + "\n");
							failed++;
							flag = 1;
							System.out.println("Sample Data FAILED FOR MUTANT (query: " + queryId + " )" + mutant);
						}

					} catch (Exception e) {
						e.printStackTrace();
						System.err.println(e);
						failed++;
						errors.add("Exception in killing mutant query:" + mutant);
						testResult.put(qId, errors);
						flag = 1;
					}

					// for every mutation in query id, add mutation stat
					long stopTime = System.currentTimeMillis();
					if (!mutantSet.contains(mutantType)) {
						mutantSet.add(mutantType);
						setquery = 1;
					} else
						setquery = 0;
					SingleMutationStat stat = new SingleMutationStat(
							0, stopTime - startTime, 0, // small and large uni no datagen
							flag, 1, setquery, 0, 0);
					mutationStat.addMutationStats(mutantType, stat); // append
					setquery = 0;// query added only once
				}
			}

			else {
				System.out.println(query);
				try {
					res = generateDataSets(queryId, query);
				} catch (Exception e) {
					res=null;
					continue;
				}
				int ignore = 0; // for continue statements

				if (res != null) {
					datasets = res.getDatasets();
					long stopTime = System.currentTimeMillis();
					res.setTimeTaken(stopTime - startTime);
				}

				if (Configuration.getProperty("printSQL").equalsIgnoreCase("true")) {
					continue;
				}

				if (datasets == null || datasets.isEmpty()) {
					System.out.println("************************Empty dataset");
					errors.add("Exception in generating datasets");
					testResult.put(qId, errors);
					ignore = 1;
					unsup = 1;
					for (Pair<String, String> p : mutantMap.get(qId)) {
						String mutant = p.getSecond();
						failedmutants += queryId + "|" + query + "\t:\t" + mutant + ":\t state='Unsupported'" + "\n";
					}

				}

				// Check if DS0 works
				try {
					if (ignore == 0 && testBasicDataset(queryId, query) == false) {
						errors.add("\tBasic datasets failed\n");
						System.out.println("BASIC dataset failed: " + queryId);
						basic = 1;
					}

				} catch (Exception e) {
					e.printStackTrace();
					errors.add("Exception in running query on basic test case");
					testResult.put(qId, errors);
					System.out
							.println("EXCEPTION: (query: " + queryId
									+ " ) Exception in running query on basic test case");
					unsup = 1;
					ignore = 1;

				}
				int failedcount = 0;
				if (!Configuration.getProperty("regressDS0").equalsIgnoreCase("true")) {
					// Check mutation killing

					Set<String> mutantSet = new HashSet<>();
					if (mutantMap.get(qId) == null) {
						continue;
					}
					for (Pair<String, String> p : mutantMap.get(qId)) {
						String mutantType = p.getFirst();
						String mutant = p.getSecond();
						int flag = 0;
						totalperq++;

						try {
							// total++;
							if (ignore == 1) {
								failperq++;
								flag = 1;
								failedcount++;
							}
							if (ignore == 0 && testMutantKilling(queryId, datasets, query, mutant) == false) {
								errors.add("\t" + mutant + "\n");
								failedmutants += queryId + "|" + query + "\t:\t" + mutant + ":\t state='NotKilled'"
										+ "\n";
								failperq++;
								flag = 1;
								failedcount++;
								// System.out.println(" FAILED FOR MUTANT (query: " + queryId + " )" + mutant);
							} else if (unsup == 0) {
								failedmutants += queryId + "|" + query + "\t:\t" + mutant + ":\t state='Killed'" + "\n";

							}

						} catch (Exception e) {
							e.printStackTrace();
							errors.add("Exception in killing mutant query:" + mutant);
							testResult.put(qId, errors);
							failperq++;
							flag = 1;
							failedcount++;
						}
						// for every mutation in query id, add mutation stat
						if (mutantSet.contains(mutantType)) {
							SingleMutationStat stat = new SingleMutationStat(
									0, 0, 0, // already added
									flag, 1, 0, 0, 0);
							mutationStat.addMutationStats(mutantType, stat); // append
						} else {
							mutantSet.add(mutantType);
							if (ignore == 1) {
								SingleMutationStat stat = new SingleMutationStat(
										0, 0, 0, // first time
										1, 1, 1, basic, unsup);
								mutationStat.addMutationStats(mutantType, stat); // append
							} else {
								SingleMutationStat stat = new SingleMutationStat(
										res.getTupleCount(), res.getTimeTaken(), res.getDatasetCount(), // first time
										flag, 1, 1, basic, unsup);
								mutationStat.addMutationStats(mutantType, stat); // append
							}
						}

					}
				}
				// done for queryType
				Set<String> querySet = new HashSet<>();
				int noofmutations = mutantMap.get(qId).size();
				String stats = "";
				stats += queryId + "," + queryType + "," + res.getTimeTaken() + "," + res.getDatasetCount() + ","
						+ res.getTupleCount() + "," + basic + "," + failedcount + "," + noofmutations + "\n";

				Utilities.writeFile(myregout, stats, true);
				Utilities.writeFile(failedpairs, failedmutants, true);

				if (querySet.contains(queryType)) {
					SingleMutationStat stat = new SingleMutationStat(
							0, 0, 0, // already added
							failedcount, noofmutations, 0, 0, 0);
					queryStat.addMutationStats(queryType, stat); // append
				} else {
					querySet.add(queryType);
					if (ignore == 1) {
						SingleMutationStat stat = new SingleMutationStat(
								0, 0, 0, // first time
								failedcount, noofmutations, 1, basic, unsup);
						queryStat.addMutationStats(queryType, stat); // append
					} else {
						SingleMutationStat stat = new SingleMutationStat(
								res.getTupleCount(), res.getTimeTaken(), res.getDatasetCount(), // first time
								failedcount, noofmutations, 1, basic, unsup);
						queryStat.addMutationStats(queryType, stat); // append
					}
				}

			}

			if (!errors.isEmpty()){
				testResult.put(qId, errors);
			}

			// added by rambabu for testing
			System.out.println("query id done: " + queryId);
			System.out.println("time taken per query is: " + res.getTimeTaken());
			// System.out.println("Result Per Query: "+ res.toString());
			// for(SingleMutationStat s: mutationStat.getMutationStats().values()){
			// System.out.println("Result Per Mutation: "+ s.toString());
			// }

			failed += failperq;
			total += totalperq;
			basicfail += basic;
			unsupported += unsup;
		}

		System.out.print("Mutants-query pairs failed " + failed + " out of " + total + "\n");
		System.out.print("basic failed " + basicfail + " out of " + queryMap.size() + "\n");
		System.out.print("exception - unsupported " + unsupported + " out of " + queryMap.size() + "\n");
		System.out.println(mutationStat);

		String finalout = "\nPrinting stats mutations wise\nMutants-query pairs failed " + failed + " out of " + total
				+ "\n" + "basic failed " + basicfail + " out of " + queryMap.size() + "\n"
				+ "exception - unsupported " + unsupported + " out of " + queryMap.size() + "\n" + mutationStat;

		finalout += "\nPrinting stats original query wise\nMutants-query pairs failed " + failed + " out of " + total
				+ "\n" + "basic failed " + basicfail + " out of " + queryMap.size() + "\n"
				+ "exception - unsupported " + unsupported + " out of " + queryMap.size() + "\n" + queryStat;

		String fileP = Configuration.getProperty("homeDir") + "/regTesOutput.txt";
		Utilities.writeFile(fileP, finalout, true);

		return testResult;
	}

	private boolean testSampleDataset(String query, String mutant) throws Exception {
		// TODO Auto-generated method stub

		try (Connection testConn = getTestConn()) {
			String datasetPath = Configuration.testDir + "/benchmark-uni/DS_1.sql";
			String sampleData = Utilities.readFile(new File(datasetPath));
			PopulateTestData.deleteAllTablesFromTestUser(testConn);
			GenerateDataSet.loadSchema(testConn, schema);
			GenerateDataSet.loadSampleData(testConn, sampleData);
			String testQuery = "((" + query + ") EXCEPT ALL (" + mutant + ")) UNION ((" + mutant + ") EXCEPT ALL ("
					+ query + "))";

			PreparedStatement ptsmt = testConn.prepareStatement(testQuery);
			ResultSet rs = ptsmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) throws Exception {

		String basePath = Configuration.getProperty("base");
		String sampleDataJsonFilePath = "";
		// System.out.println("****************args len " + args.length);
		if (args.length >= 5) {
			basePath = args[0];
		}

		String dataset;
		String sample;
		String queries;
		String mutants;
		String sampleDataJson;
		String output;
		if (args.length >= 5) {
			dataset = args[1];
			sample = args[2];
			queries = args[3];
			mutants = args[4];
			sampleDataJson = args[5];
			output = args[6];

		} else {
			dataset = Configuration.dataset;
			sample = Configuration.sample;
			queries = Configuration.queries;
			mutants = Configuration.mutants;
			sampleDataJson = Configuration.sampleDataJson;
			output = Configuration.homeDir;
		}
		File folder = new File(basePath + "/" + dataset); // Replace with your folder path
		// System.out.println(basePath + "/" + dataset);
		File[] listOfFiles = folder.listFiles();
		// System.out.println(listOfFiles);

		// Arrays.sort(listOfFiles, new Comparator<File>() {

		// @Override
		// public int compare(File o1, File o2) {
		// // TODO Auto-generated method stub
		// int O1 = Integer.parseInt(o1.toString().replaceAll("[^0-9]", ""));
		// int O2 = Integer.parseInt(o2.toString().replaceAll("[^0-9]", ""));
		// return O1 - O2;
		// }
		// });
		int j = 0;
		int cnt = 0;
		// System.err.println(folder);
		for (File file : listOfFiles) {
			cnt++;
			String schemaFile = basePath + "/" + dataset + "/" + file.getName();
			// System.out.println(schemaFile);

			// if(cnt != 58 && cnt != 57) continue;
			// if(cnt != 2) continue;
			String sampleDataFile = "";
			String fileP = output + "/regTesOutput.txt";
			Utilities.writeFile(fileP, file.toString(), true);
			if (sampleDataJson.equalsIgnoreCase("true"))
				sampleDataJsonFilePath = basePath + "/" + sample + "/"
						+ file.getName().split(".sql")[0] + ".json";
			else
				sampleDataFile = basePath + "/" + sample + "/" + file.getName();
			String query = basePath + "/" + queries + "/" + file.getName().split(".sql")[0] + ".txt";
			String mutant = basePath + "/" + mutants + "/" + file.getName().split(".sql")[0] + ".txt";

			/* runtime analysis for regression test */
			long startTime = System.currentTimeMillis();
			// System.out.println(file);

			RegressionTests r = new RegressionTests(basePath, schemaFile, sampleDataFile, query, mutant,
					sampleDataJsonFilePath, file.getName(), output);
			Map<Integer, List<String>> errorsMap;
			if (Configuration.getProperty("QueryEquivalenceCheck").equalsIgnoreCase("true"))
				errorsMap = r.runRegressionTestForEquivalence();
			else
				errorsMap = r.runRegressionTests();
			if (Configuration.getProperty("printSQL").equalsIgnoreCase("true")) {
				continue;
			}

			int i = 0;
			String errors = "";
			if (errorsMap == null)
				System.out.println("Exception......");
			else if (errorsMap.isEmpty()) {
				errors = "All Test Cases Passed";
			} else {
				errors += "Following Test Cases Failed\n";
				for (Integer key : errorsMap.keySet()) {
					i++;
					errors += key + "|";
					for (String err : errorsMap.get(key)) {
						errors += err + "|";
					}
					errors += "\n";
				}
			}
			// Utilities.writeFile(basePath + File.separator + "test_result.log", errors);
			// System.out.println(errors);
			long stopTime = System.currentTimeMillis();
			// System.out.println("Stopping time of regression test is: ");
			// System.out.println(stopTime);
			System.out.println(i + " testcases failed\n");
			long elapsedTime = stopTime - startTime;
			System.out.println("Total time taken by regression test is: " + elapsedTime);
			// System.out.print(elapsedTime);
			j += i;
			// if(cnt > 3)
			// break;
		}
		System.out.println(j + " testcases failed total\n");
		// }
	}
}