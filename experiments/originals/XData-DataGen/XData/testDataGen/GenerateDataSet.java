package testDataGen;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import org.apache.derby.vti.Restriction.AND;

import generateConstraints.ConstraintGenerator;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserManager;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.create.table.CreateTable;
import net.sf.jsqlparser.statement.select.ParenthesedSelect;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.statement.select.SelectItem;
import net.sf.jsqlparser.statement.select.WithItem;
import oracle.net.aso.s;
import parsing.AppTest_Parameters;
import util.Configuration;
import util.Result;
import util.TableMap;
import util.Utilities;

public class GenerateDataSet {
	/*
	 * This function generates test datasets for a query
	 * 
	 * @param conn Database connection to use
	 * 
	 * @param queryId The query id
	 * 
	 * @param query The query for which dataset needs to be generated
	 * 
	 * @param schemaFile File containing the schema against which the query has been
	 * written
	 * 
	 * @param sampleDataFile File containing sample data to generate realistic
	 * values
	 * 
	 * @param orderDependent Whether the order of tuples in the result matter. Set
	 * this to true for queries that have ORDER BY
	 * 
	 * @param tempFilePath File path to create temporary files and datasets
	 * 
	 * @return List of dataset ids that have been generated
	 * 
	 * @throws Exception
	 */


	 public Result generateDatasetForQuery(Connection conn, int queryId, String query, String sampleDataJsonFilePath, boolean orderDependent, String tempFilePath,
	 AppTest_Parameters obj, int flag) throws Exception {
		
		return generateDatasetForQuery(conn, queryId, query, "", "", sampleDataJsonFilePath, orderDependent,
				tempFilePath, obj);

		}


	public Result generateDatasetForQuery(Connection conn, int queryId, String query, File schemaFile,
			File sampleDataFile, String sampleDataJsonFilePath, boolean orderDependent, String tempFilePath,
			AppTest_Parameters obj) throws Exception {
		String line, schema = "", sampleData = "";

		schema = Utilities.readFile(schemaFile);

		sampleData = Utilities.readFile(sampleDataFile);

		return generateDatasetForQuery(conn, queryId, query, schema, sampleData, sampleDataJsonFilePath, orderDependent,
				tempFilePath, obj);
	}

	/**
	 * This function generates test datasets for a query
	 * 
	 * @param conn           Database connection to use
	 * @param queryId        The query id
	 * @param query          The query for which dataset needs to be generated
	 * @param schema         The schema against which the query has been written
	 * @param sampleData     Sample data to generate realistic values
	 * @param orderDependent Whether the order of tuples in the result matter. Set
	 *                       this to true for queries that have ORDER BY
	 * @param tempFilePath   File path to create temporary files and datasets
	 * @return List of dataset ids that have been generated
	 * @throws Exception
	 */
	public Result generateDatasetForQuery(Connection conn, double queryId, String query, String schema,
			String sampleData, String sampleDataJsonFilePath, boolean orderDependent, String tempFilePath,
			AppTest_Parameters appTestParams) throws Exception {

		

		GenerateCVC1 cvc = new GenerateCVC1();
		if (tempFilePath == null | tempFilePath.equals("")) {
			tempFilePath = "/tmp/" + queryId;
		}
		cvc.tempFilePathWeb=tempFilePath;
		
		cvc.setFilePath(tempFilePath);
		cvc.setFne(false);
		cvc.setIpdb(false);
		cvc.setOrderindependent(orderDependent);
		cvc.setQueryId(queryId);

		if( !((sampleData.equalsIgnoreCase("") && schema.equalsIgnoreCase("")) ))
		{
			loadSchema(conn, schema);
			if (!Configuration.getProperty("sampleDataJson").equalsIgnoreCase("true")) {
				loadSampleData(conn, sampleData);
			}
		}
		// integrated with clause - function call to addWithTables
		addWithTables(conn, query, cvc);
		// integrated with clause - function call to addWithTables end
		cvc.setSchemaFile(schema);
		cvc.setDataFileName(sampleData);
		cvc.setSampleDataJsonFilePath(sampleDataJsonFilePath);

		TableMap.clearAllInstances();
		cvc.setTableMap(TableMap.getInstances(conn, 1));
		cvc.setConnection(conn);

		deletePreviousDatasets(cvc);
		// Application Testing
		if (appTestParams == null)
			appTestParams = new AppTest_Parameters();
		cvc.setDBAppparams(appTestParams);
		// end
		FileWriter fw = new FileWriter(Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/queries.txt");
		fw.write(query);
		fw.close();

		if (Configuration.getProperty("printSQL").equalsIgnoreCase("true")) {
			File directory = new File(Configuration.getProperty("printDir") + "/" + cvc.getQueryId());
			if (directory.exists())
				deleteDirectory(directory);
			directory.mkdir();
		}

		PreProcessingActivity.preProcessingActivity(cvc);
		ConstraintGenerator cg = new ConstraintGenerator();
		cg.clearContext();
		Result res = new Result(listOfDatasets(cvc), cvc.getTupleCount(),cvc.result,cvc.totalTime);
		conn.close();
		return res;
	}

	// integrated with clause - find and WITH tables
	public static void addWithTables(Connection conn, String queryString, GenerateCVC1 cvc) {
		try {
			// Create a parser manager instance.
			CCJSqlParserManager pm = new CCJSqlParserManager();
			// Parse the provided SQL query.
			net.sf.jsqlparser.statement.Statement stmt = pm.parse(new StringReader(queryString));
			// Check if the statement is a SELECT statement.
			if (!(stmt instanceof Select)) {
				return;
			}
			Select selectClause = (Select) stmt;
			// Retrieve the list of WITH clauses.
			List<WithItem> withItemsList = selectClause.getWithItemsList();
			// If there are no WITH clauses, return.
			if (withItemsList == null || withItemsList.isEmpty()) {
				return;
			}
			cvc.withColumnMappings = new HashMap<>();
			// Process each WITH clause item.
			for (WithItem withItem : withItemsList) {
				String tableName = withItem.getAlias().toString();

				// 2. Extract the SELECT statement inside the WITH clause
				ParenthesedSelect ps = (ParenthesedSelect) (Select) withItem;
				PlainSelect p = ps.getSelect().getPlainSelect();
				p.setWhere(null);
				// 3. Construct CREATE TEMP TABLE statement
				String createTableSQL = "create temporary table " + tableName.trim() + " AS " + p.toString();
				loadWithSchema(conn, createTableSQL, withItem, cvc);
			}
		} catch (Exception e) {
			return;
		}

	}
	// integrated with clause - find and WITH tables

	// integrated with clause - load schema for WITH
	public static void loadWithSchema(Connection conn, String schema, WithItem srcWithItem, GenerateCVC1 cvc)
			throws Exception {
		byte[] dataBytes = schema.getBytes();
		String tempFile = "/tmp/dummy";
		List<String> newColumnNames = new ArrayList<>();

		// Write schema data to file
		try (FileOutputStream fos = new FileOutputStream(tempFile)) {
			fos.write(dataBytes);
		}

		// Generate list of queries
		ArrayList<String> listOfQueries = Utilities.createQueries(tempFile);
		String[] inst = listOfQueries.toArray(new String[0]);
		String tableName = srcWithItem.getAlias().toString().trim();

		
		
		for (String query : inst) {
			if (!query.trim().isEmpty() && !query.trim().toLowerCase().contains("drop table")) {
				DatabaseMetaData dbmd = conn.getMetaData();
				String dbType = dbmd.getDatabaseProductName();
				String tempQuery = query.trim();

				// Modify query based on database type
				if (dbType.equalsIgnoreCase("PostgreSQL")) {
					tempQuery = tempQuery.replaceAll("(?i)^\\s*create\\s+table\\s+", "create temporary table ");
				}

				// Execute query
				try (PreparedStatement stmt = conn.prepareStatement(tempQuery)) {
					stmt.executeUpdate();
				}
				// Fetch column names from the created table
				List<String> oldColumnNames = new ArrayList<>();
				String database = conn.getCatalog();
				ResultSet rs = dbmd.getTables(database, "", "%", null);
				while (rs.next()) {
					String table = rs.getString("TABLE_NAME");
					if (table.equalsIgnoreCase(tableName)) {
						break;
					}
				}
				rs = dbmd.getColumns(database, "", tableName.toLowerCase(), "%");
				while (rs.next()) {
					String columnName = rs.getString("COLUMN_NAME");
					oldColumnNames.add(columnName);
				}
				rs.close();

				
				if (srcWithItem.getWithItemList() == null) {
					List<String> oldColBeforAs = new ArrayList<>();
					oldColBeforAs = extractOriginalColumnsFromQuery(tempQuery);
					if (oldColBeforAs.size() > 0 && oldColBeforAs.get(0) == "*") {
						return;
					}
					List<AbstractMap.SimpleEntry<String, String>> columnmapping = new ArrayList<>();
					for (int i = 0; i < oldColBeforAs.size(); i++) {
						if (!oldColBeforAs.get(i).equalsIgnoreCase(oldColumnNames.get(i))) {
							columnmapping
									.add(new AbstractMap.SimpleEntry<>(oldColumnNames.get(i), oldColBeforAs.get(i)));
						}
					}
					if (columnmapping.size() != 0) {
						cvc.withColumnMappings.put(tableName.toLowerCase(), columnmapping);
					}
					return;
				}

				for (int i = 0; i < srcWithItem.getWithItemList().size(); i++) {
					String newColumnName = srcWithItem.getWithItemList().get(i).toString();
					newColumnNames.add(newColumnName);
				}

				// Ensure column count matches before renaming
				if (oldColumnNames.size() != srcWithItem.getWithItemList().size()) {
					throw new Exception("Column count mismatch: Cannot rename columns");
				}

				List<?> withItemList = srcWithItem.getWithItemList();
				if (withItemList == null || withItemList.isEmpty()) {
					throw new IllegalArgumentException("No columns found in WITH item list.");
				}

				// Construct column rename query
				if (oldColumnNames.size() != newColumnNames.size()) {
					throw new Exception("Column count mismatch: Cannot rename columns");
				}
				List<AbstractMap.SimpleEntry<String, String>> columnmapping = new ArrayList<>();
				for (int i = 0; i < oldColumnNames.size(); i++) {
					if (oldColumnNames.get(i).equalsIgnoreCase(newColumnNames.get(i))) {
						continue;
					}
					String alterSQL = "ALTER TABLE " + tableName + " RENAME COLUMN " + oldColumnNames.get(i) + " TO "
							+ newColumnNames.get(i) + ";";
					try (PreparedStatement renameStmt = conn.prepareStatement(alterSQL.toString())) {
						renameStmt.executeUpdate();
					}
					columnmapping.add(new AbstractMap.SimpleEntry<>(newColumnNames.get(i), oldColumnNames.get(i)));

				}
				cvc.withColumnMappings.put(tableName.toLowerCase(), columnmapping);

				// Debug: Print rename query

			}
		}
	}
	// integrated with clause - load schema for WITH end

	// integrated with clause - extract original columns for WITH
	public static List<String> extractOriginalColumnsFromQuery(String query) {
		List<String> columns = new ArrayList<>();

		try {
			net.sf.jsqlparser.statement.Statement statement = CCJSqlParserUtil.parse(query);

			if (statement instanceof CreateTable) {
				CreateTable createTable = (CreateTable) statement;
				if (createTable.getSelect() != null) {
					Select selectStatement = createTable.getSelect();
					PlainSelect plainSelect = (PlainSelect) selectStatement.getSelectBody();

					List<SelectItem<?>> selectItems = plainSelect.getSelectItems();

					for (SelectItem selectItem : selectItems) {
						String itemStr = selectItem.toString();

						if (itemStr.equals("*")) {
							columns.add("*");
						} else if (itemStr.endsWith(".*")) {
							columns.add(itemStr);
						} else {
							if (itemStr.toLowerCase().contains(" as ")) {
								String[] parts = itemStr.split("(?i)\\s+as\\s+");
								if (parts.length > 1) {
									if (itemStr.contains("(") && itemStr.contains(")")) {
										columns.add(parts[1].trim());
									} else if (parts[0].contains(".")) {
										columns.add(parts[0].split("\\.")[1]);
									} else {
										columns.add(parts[0].trim());
									}

								}
							} else if (itemStr.matches(".*\\s+\\w+$") && !itemStr.contains("(")) {
								String[] parts = itemStr.trim().split("\\s+");
								columns.add(parts[parts.length - 1]);
							} else if (itemStr.contains(".") && !itemStr.equals("*")) {
								String[] parts = itemStr.split("\\.");
								columns.add(parts[1].trim());
							} else {
								columns.add(itemStr);
							}
						}
					}
				}
			}
		} catch (JSQLParserException e) {
			System.err.println("Failed to parse SQL: " + e.getMessage());
		}

		return columns;
	}
	// integrated with clause - extract original columns for WITH end

	private boolean deleteDirectory(File directory) {
		if (directory.isDirectory()) {
			File[] files = directory.listFiles();
			if (files != null) {
				for (File file : files) {
					deleteDirectory(file);
				}
			}
		}
		return directory.delete();
	}

	/**
	 * Creates tables provided in the schema for the given connection
	 * 
	 * @param conn
	 * @param schema
	 * @throws Exception
	 */
	public static void loadSchema(Connection conn, String schema) throws Exception {

		byte[] dataBytes = null;
		String tempFile = "";
		FileOutputStream fos = null;
		ArrayList<String> listOfQueries = null;
		ArrayList<String> listOfDDLQueries = new ArrayList<String>();
		String[] inst = null;

		dataBytes = schema.getBytes();
		tempFile = "/tmp/dummy";

		fos = new FileOutputStream(tempFile);
		fos.write(dataBytes);
		fos.close();
		listOfQueries = Utilities.createQueries(tempFile);
		inst = listOfQueries.toArray(new String[listOfQueries.size()]);
		listOfDDLQueries.addAll(listOfQueries);
		deleteAllTablesFromTestUser(conn);

		for (int i = 0; i < inst.length; i++) {

			if (!inst[i].trim().equals("") && !inst[i].trim().contains("drop table")) {
				DatabaseMetaData dbmd = conn.getMetaData();
				String dbType = dbmd.getDatabaseProductName();
				String temp = "";
				if (dbType.equalsIgnoreCase("MySql")) {
					temp = inst[i].trim();
				} else if (dbType.equalsIgnoreCase("PostgreSQL")) {
					temp = inst[i].trim().replaceAll("(?i)^\\s*create\\s+table\\s+", "create temporary table ");
				} else if (dbType.equalsIgnoreCase("sqlite")) {
					// temp = inst[i].trim();
					if (!inst[i].toUpperCase().contains("IF NOT EXISTS"))
						temp = inst[i].trim().replaceAll("(?i)^\\s*create\\s+table\\s+", "create table IF NOT EXISTS ");
					else
						temp = inst[i];
					String temp2 = temp.toUpperCase();
				}

				PreparedStatement stmt2 = conn.prepareStatement(temp);
				stmt2.executeUpdate();
				stmt2.close();
			}

		}
	}

	/**
	 * Loads datasets for the given connection
	 * 
	 * @param conn
	 * @param sampleData
	 * @throws Exception
	 */
	public static void loadSampleData(Connection conn, String sampleData) throws Exception {

		byte[] dataBytes = null;
		String tempFile = "/tmp/dummy";
		FileOutputStream fos = null;
		ArrayList<String> listOfQueries = null;
		String[] inst = null;

		dataBytes = sampleData.getBytes();
		fos = new FileOutputStream(tempFile);
		fos.write(dataBytes);
		fos.close();

		listOfQueries = Utilities.createQueries(tempFile);
		inst = listOfQueries.toArray(new String[listOfQueries.size()]);

		for (int i = 0; i < inst.length; i++) {
			//if (!inst[i].trim().equals("") && !inst[i].contains("drop table") && !inst[i].contains("delete from")) {
			if (!inst[i].trim().equals("") && !inst[i].contains("drop table")) {

				PreparedStatement stmt = conn.prepareStatement(inst[i]);
				stmt.executeUpdate();
				stmt.close();
			}
		}
	}

	private List<String> listOfDatasets(GenerateCVC1 cvc) {
		ArrayList<String> fileListVector = new ArrayList<String>();
		ArrayList<String> datasets = new ArrayList<String>();
		String fileList[] = new File(Configuration.homeDir + "/temp_smt" + cvc.getFilePath()).list();
		for (int k = 0; k < fileList.length; k++) {
			fileListVector.add(fileList[k]);
		}
		Collections.sort(fileListVector);
		for (int i = 0; i < fileList.length; i++) {
			File f1 = new File(Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/" + fileListVector.get(i));

			if (f1.isFile() && fileListVector.get(i).startsWith("DS")) {
				datasets.add(fileListVector.get(i));
			}
		}
		return datasets;
	}

	public static void deletePreviousDatasets(GenerateCVC1 cvc) throws IOException, InterruptedException {

		File f = new File(Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/");

		if (f.exists()) {
			File f2[] = f.listFiles();
			if (f2 != null)
				for (int i = 0; i < f2.length; i++) {
					if (f2[i].isDirectory() && f2[i].getName().startsWith("DS")) {

						Utilities.deletePath(
								Configuration.homeDir + "/temp_smt" + cvc.getFilePath() + "/" + f2[i].getName());
					}
				}
		}

		File dir = new File(Configuration.homeDir + "/temp_smt" + cvc.getFilePath());
		if (dir.exists()) {
			for (File file : dir.listFiles()) {
				file.delete();
			}
		} else {
			dir.mkdirs();
		}
	}

	public static void deleteAllTablesFromTestUser(Connection conn) throws Exception {
		try {

			String loginUrl = "";
			String tempDatabaseType = Configuration.getProperty("tempDatabaseType");

			if (tempDatabaseType.equalsIgnoreCase("postgresql")) {

				Class.forName("org.postgresql.Driver");

				loginUrl = "jdbc:postgresql://" + Configuration.getProperty("databaseIP") + ":"
						+ Configuration.getProperty("databasePort") + "/" + Configuration.getProperty("databaseName");
			}
			else
			{
				loginUrl = "jdbc:sqlite" + ":" + Configuration.getProperty("homeDir")
					+ Configuration.getProperty("databaseName");
			}
			conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
					Configuration.getProperty("testDatabaseUserPasswd"));

			DatabaseMetaData dbm = conn.getMetaData();

			// added by rambabu
			String dbType = dbm.getDatabaseProductName();

			if (dbType.equalsIgnoreCase("MySql")) {
				String[] types = { "TABLE" };
				ResultSet rs = dbm.getTables(conn.getCatalog(), null, "%", types);

				// ResultSet rs = dbm.getTables(null, null, "%", types);
				// while (rs.next()) {
				// System.out.println(rs.getString(3));
				// }
				String query = "SET FOREIGN_KEY_CHECKS = 0";
				if (dbType.equalsIgnoreCase("sqlite"))
					query = "PRAGMA foreign_keys=off;";
				PreparedStatement pstmt = conn.prepareStatement(query);
				pstmt.executeUpdate();
				pstmt.close();

				while (rs.next()) {
					String table = rs.getString("TABLE_NAME");
					if (!table.equalsIgnoreCase("dataset")
							&& !table.equalsIgnoreCase("xdata_temp1")
							&& !table.equalsIgnoreCase("xdata_temp2")) {
						System.out.println("drop table if exists " + table + " cascade");
						// PreparedStatement pstmt = conn.prepareStatement("delete from "+table);
						// PreparedStatement pstmt = conn.prepareStatement("drop table if exists "+table
						// +" cascade");
						// pstmt.executeUpdate();
						// pstmt.close();

						query = "drop table if exists " + table;
						PreparedStatement pstmt1 = conn.prepareStatement(query);
						pstmt1.executeUpdate();
						pstmt1.close();
					}

				}

				query = "SET FOREIGN_KEY_CHECKS = 1";
				PreparedStatement pstmt2 = conn.prepareStatement(query);
				pstmt2.executeUpdate();
				pstmt2.close();

				rs.close();

			} else if (dbType.equalsIgnoreCase("sqlite")) {
				String[] types = { "TABLE" };
				ResultSet rs = dbm.getTables(conn.getCatalog(), null, "%", types);

				rs = dbm.getTables(null, null, "%", types);
				Vector<String> tables = getTablesToDrop(conn);

				String query = "PRAGMA foreign_keys = OFF;";
				Statement stmt = conn.createStatement();
				stmt.executeUpdate(query);
				stmt.close();

				for (String table : tables) {
					// String table=rs.getString("TABLE_NAME");
					if (!table.equalsIgnoreCase("dataset")
							&& !table.equalsIgnoreCase("xdata_temp1")
							&& !table.equalsIgnoreCase("xdata_temp2")) {
						// System.out.println("drop table if exists "+table +" cascade");
						// PreparedStatement pstmt = conn.prepareStatement("delete from "+table);
						// PreparedStatement pstmt = conn.prepareStatement("drop table if exists "+table
						// +" cascade");
						// pstmt.executeUpdate();
						// pstmt.close();
						// query = "select * from "+ table;
						// stmt.executeUpdate(query);

						// query = "select * from " + table;
						// query = "drop table "+table;
						query = "DELETE FROM " + table;
						stmt.setQueryTimeout(30); // set timeout to 30 sec.
						PreparedStatement pstmt1 = conn.prepareStatement(query);
						pstmt1.executeUpdate();
						pstmt1.close();
					}

				}

				query = "PRAGMA foreign_keys=on;";
				PreparedStatement pstmt2 = conn.prepareStatement(query);
				pstmt2.executeUpdate();
				pstmt2.close();

				rs.close();

			} else if (dbType.equalsIgnoreCase("postgreSQL")) {
				String[] types = { "TEMPORARY TABLE" };
				ResultSet rs = dbm.getTables(conn.getCatalog(), null, "%", types);

				while (rs.next()) {
					String table = rs.getString("TABLE_NAME");
					if (!table.equalsIgnoreCase("dataset")
							&& !table.equalsIgnoreCase("xdata_temp1")
							&& !table.equalsIgnoreCase("xdata_temp2")) {
						// PreparedStatement pstmt = conn.prepareStatement("delete from "+table);
						PreparedStatement pstmt = conn.prepareStatement("Truncate table " + table + " cascade");
						pstmt.executeUpdate();
						pstmt.close();
					}

				}

				rs.close();
			}

		} catch (Exception e) {
			System.out.println(e);
		}

	}

	public static String convertBackticksToSingleQuotes(String sql) {
		return sql.replace("`", "'");
	}

	private static Vector<String> getTablesToDrop(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		Vector<String> tables = new Vector<String>();

		String[] types = { "TABLE" };
		DatabaseMetaData dbm = conn.getMetaData();

		ResultSet rs = dbm.getTables(conn.getCatalog(), null, "%", types);

		while (rs.next()) {
			tables.add(rs.getString("TABLE_NAME"));
			// System.out.println(rs.getString("TABLE_NAME"));
		}
		rs.close();
		return tables;
		// throw new UnsupportedOperationException("Unimplemented method
		// 'getTablesToDrop'");
	}

	public static void main(String[] args) throws Exception {

		// TEMPCODE START : Rahul Sharma
		// REGRESSION TEST
		int regression_test = 0;
		if (regression_test == 1) {
			int start = 1;
			int end = 54;
			// end = start = 27;
			for (int i = start; i <= end; i++) {
				int queryId = i;
				String query = readQueryFromFile("test/universityTest/queries.txt", queryId + "");
				String tempDatabaseType = Configuration.getProperty("tempDatabaseType");
				String loginUrl = "";
				Connection conn = null;

				// choosing connection based on database type
				if (tempDatabaseType.equalsIgnoreCase("postgresql")) {
					Class.forName("org.postgresql.Driver");

					loginUrl = "jdbc:postgresql://" + Configuration.getProperty("databaseIP") + ":"
							+ Configuration.getProperty("databasePort") + "/"
							+ Configuration.getProperty("databaseName");
					conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
							Configuration.getProperty("testDatabaseUserPasswd"));
					;
				} else if (tempDatabaseType.equalsIgnoreCase("mysql")) {
					Class.forName("com.mysql.cj.jdbc.Driver");

					loginUrl = "jdbc:mysql://" + Configuration.getProperty("databaseIP") + ":"
							+ Configuration.getProperty("databasePort") + "/"
							+ Configuration.getProperty("databaseName");
					conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
							Configuration.getProperty("testDatabaseUserPasswd"));
					;
				}
				try {
					File schemaFile = new File("test/universityTest/DDL.sql");
					File sampleDataFile = new File("test/universityTest/sampleData.sql");
					String sampleDataJsonFilePath = ""; // Put json path here
					if (Configuration.sampleDataJson.equalsIgnoreCase("true"))
						sampleDataJsonFilePath = "test/universityTest/sample.json";
					boolean orderDependent = false;
					/* runtime analysis for regression test */
					long startTime = System.currentTimeMillis();
					String tempFilePath = File.separator + queryId;

					GenerateDataSet d = new GenerateDataSet();
					// Application Testing
					AppTest_Parameters obj = new AppTest_Parameters();

					// end
					Result res = d.generateDatasetForQuery(conn, queryId, query, schemaFile, sampleDataFile,
							sampleDataJsonFilePath, orderDependent, tempFilePath, obj);
					List<String> dataset = res.getDatasets();
					for (String s : dataset) {
						System.out.println(s);
					}

					long stopTime = System.currentTimeMillis();
					long elapsedTime = stopTime - startTime;
					System.out.println("Total time taken for data generation of the query " + queryId + " is : ");
					System.out.println(elapsedTime);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("Query : " + query + "\n" + e);
				}
			}
			// TEMPCODE END : Rahul Sharma
		} else {

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

				File file = new File(Configuration.getProperty("homeDir")+ Configuration.getProperty("databaseName")); // Replace with your database path
				if (file.delete()) {
					System.out.println("Database file has been deleted successfully.");
				} 
				file = new File(Configuration.getProperty("homeDir")+ Configuration.getProperty("databaseName")+"-shm"); // Replace with your database path
				if (file.delete()) {
					System.out.println("Database file shm has been deleted successfully.");
				} 
				file = new File(Configuration.getProperty("homeDir")+ Configuration.getProperty("databaseName")+"-wal"); // Replace with your database path
				if (file.delete()) {
					System.out.println("Database file wal has been deleted successfully.");
				} 
				// else {
				// 	System.out.println("Failed to delete the database file.");
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

			int queryId = 102;
			String query="select dept_name, dense_rank() over ( ORDER BY salary ) as rank from instructor";

			
			query="(SELECT MGR, SUM(SUM_SAL) FROM (SELECT MGR, SUM(SAL) AS SUM_SAL FROM EMP GROUP BY MGR, DEPTNO HAVING DEPTNO = 100) AS t2 GROUP BY MGR) except (SELECT MGR, SUM(SAL) AS SUM_SAL FROM EMP GROUP BY MGR, DEPTNO HAVING DEPTNO = 100)";
			// query="SELECT ENAME, SAL, DEPTNO FROM (SELECT ENAME, SAL, DEPTNO FROM EMP GROUP BY ENAME, SAL, DEPTNO HAVING SAL > 5000) AS t4 GROUP BY ROLLUP(ENAME, SAL, DEPTNO)";
			File schemaFile=new File(Configuration.testDir+"/Calcite/dataset/calcite.sql");
			File sampleDataFile=new File(Configuration.testDir+"/Calcite/sample/calcite.sql");
			String sampleDataJsonFilePath = "";
			if (Configuration.sampleDataJson.equalsIgnoreCase("true"))
				sampleDataJsonFilePath = Configuration.testDir + "/uni1/sample.json"; // Put json path here -
																								// sunanda

			boolean orderDependent = false;
			long startTime = System.currentTimeMillis();
			String tempFilePath = File.separator + queryId;

			GenerateDataSet d = new GenerateDataSet();
			// Application Testing
			AppTest_Parameters obj = new AppTest_Parameters();

				if (args.length > 0)  query = args[0];
				System.out.println("\n"+query+"\n");
				
				Result res = d.generateDatasetForQuery(conn,queryId,query,  schemaFile,  sampleDataFile, sampleDataJsonFilePath,  orderDependent,  tempFilePath, obj);
				List<String> dataset = res.getDatasets();
				for(String s:dataset) {
					System.out.println(s);
				}
				System.out.println("\nNumber of datatsets: "+dataset.size()+"\n");
				long stopTime = System.currentTimeMillis();
				long elapsedTime = stopTime - startTime;
		        System.out.println("Total time taken for data generation of the query is : "+elapsedTime);
			}
		}

	// TEMPCODE Rahul Sharma
	public static String readQueryFromFile(String fileName, String queryId) throws IOException {
		File file = new File(fileName);
		@SuppressWarnings("resource")
		BufferedReader br = new BufferedReader(new FileReader(file));
		String st;
		while ((st = br.readLine()) != null) {
			// System.out.println(st);
			if (st.length() > 0) {
				StringTokenizer stok = new StringTokenizer(st, "|");
				if (stok.nextToken().contentEquals(queryId))
					return stok.nextToken();
			}
		}
		return "";
	}

}
