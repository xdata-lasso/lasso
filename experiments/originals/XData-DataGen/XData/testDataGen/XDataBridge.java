package testDataGen;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.Configuration;
import util.Result;
import util.Utilities;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class XDataBridge {

    public static class DatasetItem {
        public String name;
        public String sql;

        public DatasetItem(String name, String sql) {
            this.name = name;
            this.sql = sql;
        }
    }

    public static class BridgeOutput {
        public String status; // SUCCESS, ERROR, NO_DATASETS
        public List<DatasetItem> datasets;
        public int num_datasets;
        public String error;
        public long time_taken_ms;

        public BridgeOutput() {
            this.datasets = new ArrayList<>();
            this.status = "SUCCESS";
            this.num_datasets = 0;
            this.error = "";
            this.time_taken_ms = 0;
        }
    }

    private static Connection getPostgresConnection() throws Exception {
        Class.forName("org.postgresql.Driver");
        String loginUrl = "jdbc:postgresql://" + Configuration.getProperty("databaseIP") + ":"
                + Configuration.getProperty("databasePort") + "/" + Configuration.getProperty("databaseName");
        Connection conn = DriverManager.getConnection(loginUrl, Configuration.getProperty("testDatabaseUser"),
                Configuration.getProperty("testDatabaseUserPasswd"));
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("SET session_replication_role = 'replica'");
        } catch (Exception ignored) {
        }
        return conn;
    }

    public static void main(String[] args) {
        BridgeOutput output = new BridgeOutput();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        if (args.length < 4) {
            output.status = "ERROR";
            output.error = "Usage: XDataBridge <schema_file> <sample_data_file> <query_file> <output_json_file> [query_id]";
            System.err.println(output.error);
            writeOutput(output, args.length >= 4 ? args[3] : "output_bridge.json", gson);
            System.exit(1);
        }

        String schemaFilePath = args[0];
        String sampleDataFilePath = args[1];
        String queryFilePath = args[2];
        String outputJsonPath = args[3];
        int queryId = 1;
        if (args.length >= 5) {
            try {
                queryId = Integer.parseInt(args[4]);
            } catch (Exception ignored) {
            }
        }

        long startTime = System.currentTimeMillis();
        String tempFilePath = File.separator + "bridge_" + queryId + "_" + System.currentTimeMillis();

        try {
            File schemaFile = new File(schemaFilePath);
            File sampleDataFile = new File(sampleDataFilePath);
            File queryFile = new File(queryFilePath);

            if (!schemaFile.exists()) {
                throw new IllegalArgumentException("Schema file does not exist: " + schemaFilePath);
            }
            if (!sampleDataFile.exists()) {
                throw new IllegalArgumentException("Sample data file does not exist: " + sampleDataFilePath);
            }

            String schemaContent = Utilities.readFile(schemaFile);
            String sampleDataContent = Utilities.readFile(sampleDataFile);
            String queryContent = queryFile.exists() ? Utilities.readFile(queryFile).trim() : queryFilePath.trim();

            Connection conn = getPostgresConnection();

            GenerateDataSet generator = new GenerateDataSet();
            Result res = generator.generateDatasetForQuery(
                    conn,
                    queryId,
                    queryContent,
                    schemaContent,
                    sampleDataContent,
                    "",
                    false,
                    tempFilePath,
                    null);

            File dsFolder = new File(Configuration.homeDir + "/temp_smt" + tempFilePath);
            if (dsFolder.exists()) {
                File[] files = dsFolder.listFiles();
                if (files != null) {
                    List<File> dsSqlFiles = new ArrayList<>();
                    for (File f : files) {
                        if (f.isFile() && f.getName().startsWith("DS") && f.getName().endsWith(".sql")) {
                            dsSqlFiles.add(f);
                        }
                    }
                    Collections.sort(dsSqlFiles, (a, b) -> a.getName().compareTo(b.getName()));

                    for (File sqlFile : dsSqlFiles) {
                        StringBuilder sb = new StringBuilder();
                        try (BufferedReader br = new BufferedReader(new FileReader(sqlFile))) {
                            String line;
                            while ((line = br.readLine()) != null) {
                                String trimmed = line.trim();
                                if (trimmed.isEmpty() || trimmed.startsWith("--")) {
                                    continue;
                                }
                                if (trimmed.toLowerCase().startsWith("delete from")) {
                                    continue; // execution tester starts with clean table
                                }
                                if (!trimmed.endsWith(";")) {
                                    trimmed += ";";
                                }
                                sb.append(trimmed).append("\n");
                            }
                        }
                        String cleanedSql = sb.toString().trim();
                        if (!cleanedSql.isEmpty()) {
                            output.datasets.add(new DatasetItem(sqlFile.getName(), cleanedSql));
                        }
                    }
                }
            }

            output.num_datasets = output.datasets.size();
            output.status = output.num_datasets > 0 ? "SUCCESS" : "NO_DATASETS";

            // Cleanup temp directory
            if (dsFolder.exists()) {
                deleteDirectory(dsFolder);
            }

        } catch (Throwable e) {
            output.status = "ERROR";
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            output.error = sw.toString();
            System.err.println("XDataBridge Error: " + sw.toString());
            // Also clean up temp directory if it exists
            File dsFolder = new File(Configuration.homeDir + "/temp_smt" + tempFilePath);
            if (dsFolder.exists()) {
                deleteDirectory(dsFolder);
            }
        } finally {
            output.time_taken_ms = System.currentTimeMillis() - startTime;
            writeOutput(output, outputJsonPath, gson);
        }
    }

    private static void writeOutput(BridgeOutput output, String path, Gson gson) {
        try (FileWriter fw = new FileWriter(path)) {
            gson.toJson(output, fw);
        } catch (Exception e) {
            System.err.println("Failed to write bridge output to " + path + ": " + e.getMessage());
        }
    }

    private static void deleteDirectory(File dir) {
        if (dir.isDirectory()) {
            File[] files = dir.listFiles();
            if (files != null) {
                for (File f : files) {
                    deleteDirectory(f);
                }
            }
        }
        dir.delete();
    }
}
