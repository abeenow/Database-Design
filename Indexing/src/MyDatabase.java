
import com.opencsv.CSVReader;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;

import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

public class MyDatabase {

    String dir;
    File csv_path;
    File bin_path;
    File[] index_files;

    TreeMap<Integer, Long> id_ndx;
    TreeMap<String, ArrayList<Long>> company_ndx, drug_id_ndx;
    TreeMap<Short, ArrayList<Long>> trials_ndx, patients_ndx, dosage_mg_ndx;
    TreeMap<Float, ArrayList<Long>> reading_ndx;
    TreeMap<Boolean, ArrayList<Long>> double_blind_ndx, controlled_study_ndx, govt_funded_ndx, fda_approved_ndx;

    public MyDatabase() {

        dir = System.getProperty("user.dir");
        csv_path = new File(dir + File.separator + "PHARMA_TRIALS_1000B.csv");
        bin_path = new File(dir + File.separator + "data.db");

        id_ndx = new TreeMap();

        company_ndx = new TreeMap();
        drug_id_ndx = new TreeMap();

        trials_ndx = new TreeMap();
        patients_ndx = new TreeMap();
        dosage_mg_ndx = new TreeMap();

        reading_ndx = new TreeMap();

        double_blind_ndx = new TreeMap();
        controlled_study_ndx = new TreeMap();
        govt_funded_ndx = new TreeMap();
        fda_approved_ndx = new TreeMap();

        index_files = new File[11];
        index_files[0] = new File(dir + File.separator + "id.ndx");
        index_files[1] = new File(dir + File.separator + "company.ndx");
        index_files[2] = new File(dir + File.separator + "drug_id.ndx");
        index_files[3] = new File(dir + File.separator + "trials.ndx");
        index_files[4] = new File(dir + File.separator + "patients.ndx");
        index_files[5] = new File(dir + File.separator + "dosage_mg.ndx");
        index_files[6] = new File(dir + File.separator + "reading.ndx");
        index_files[7] = new File(dir + File.separator + "double_blind.ndx");
        index_files[8] = new File(dir + File.separator + "controlled_study.ndx");
        index_files[9] = new File(dir + File.separator + "govt_funded.ndx");
        index_files[10] = new File(dir + File.separator + "fda_approved.ndx");

    }

    private String read_value() {
        String choice = "0";
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            choice = br.readLine();
        } catch (Exception e) {
            System.err.println("Exception occured " + e);
            System.err.println("Aborting program");
            System.exit(1);
        }
        return choice;
    }

    public void display_main_menu() throws Exception {
        int choice = 0;
        do {
            if (choice == 0) {
                System.out.println("***** Welcome!! ***** \n ***** Pharma Database *****\n\t 1. Build binary file \n\t 2.Query \n\tEnter Your choice:");
            } else {
                System.out.println("Invalid choice entered,please choose 1/2");
            }
            choice = Integer.parseInt(read_value());

        } while (!(choice == 1 || choice == 2));
        display_sub_menu(choice);
    }

    private ArrayList<Long> get_array_list(String key, long val, Map<String, ArrayList<Long>> map) {
        ArrayList<Long> result = new ArrayList<>();
        if (map.containsKey(key)) {
            result = map.get(key);
            result.add(val);
        } else {
            result.add(val);
        }
        return result;
    }

    private ArrayList<Long> get_array_list(short key, long val, Map<Short, ArrayList<Long>> map) {
        ArrayList<Long> result = new ArrayList<>();
        if (map.containsKey(key)) {
            result = map.get(key);
            result.add(val);
        } else {
            result.add(val);
        }
        return result;
    }

    private ArrayList<Long> get_array_list(float key, long val, Map<Float, ArrayList<Long>> map) {
        ArrayList<Long> result = new ArrayList<>();
        if (map.containsKey(key)) {
            result = map.get(key);
            result.add(val);
        } else {
            result.add(val);
        }
        return result;
    }

    private ArrayList<Long> get_array_list(boolean key, long val, Map<Boolean, ArrayList<Long>> map) {
        ArrayList<Long> result = new ArrayList<>();
        if (map.containsKey(key)) {
            result = map.get(key);
            result.add(val);
        } else {
            result.add(val);
        }
        return result;
    }

    private void write_indices(TreeMap map, File file) {
        try {
            FileWriter f = new FileWriter(file);
            for (Object key : map.keySet()) {
                String content = key.toString() + "=" + map.get(key).toString().replace("[", "") + System.getProperty("line.separator");
                f.write(content.replace("]", "").replace(" ", ""));
            }
            f.close();
        } catch (Exception e) {
            System.err.println("Write to file failed:" + e);
        }

    }

    private void build_db() {
        if (!csv_path.isFile()) {
            System.err.println("CSV file missing at " + csv_path.toString());
            System.exit(1);
        }
        try {
            CSVReader reader = new CSVReader(new FileReader(csv_path), ',', '"', 1);
            RandomAccessFile out = new RandomAccessFile(bin_path, "rw");
            String[] line;
            while ((line = reader.readNext()) != null) {
                if (line != null) {

                    long filepointer = out.getFilePointer();

                    int id = Integer.parseInt(line[0]);
                    out.writeInt(id);
                    id_ndx.put(id, filepointer);

                    String company = line[1];
                    int size = company.length();
                    out.writeInt(size);
                    out.writeChars(company);
                    company_ndx.put(company, get_array_list(company, filepointer, company_ndx));

                    String drug_id = line[2];
                    out.writeChars(drug_id);
                    drug_id_ndx.put(drug_id, get_array_list(drug_id, filepointer, drug_id_ndx));

                    short trials = Short.parseShort(line[3]);
                    out.writeShort(trials);
                    trials_ndx.put(trials, get_array_list(trials, filepointer, trials_ndx));

                    short patients = Short.parseShort(line[4]);
                    out.writeShort(patients);
                    patients_ndx.put(patients, get_array_list(patients, filepointer, patients_ndx));

                    short dosage_mg = Short.parseShort(line[5]);
                    out.writeShort(dosage_mg);
                    dosage_mg_ndx.put(dosage_mg, get_array_list(dosage_mg, filepointer, dosage_mg_ndx));

                    float reading = Float.parseFloat(line[6]);
                    out.writeFloat(reading);
                    reading_ndx.put(reading, get_array_list(reading, filepointer, reading_ndx));

                    boolean double_blind = line[7].equalsIgnoreCase("true");
                    out.writeBoolean(double_blind);
                    double_blind_ndx.put(double_blind, get_array_list(double_blind, filepointer, double_blind_ndx));

                    boolean controlled_study = line[8].equalsIgnoreCase("true");
                    out.writeBoolean(controlled_study);
                    controlled_study_ndx.put(controlled_study, get_array_list(controlled_study, filepointer, controlled_study_ndx));

                    boolean govt_funded = line[9].equalsIgnoreCase("true");
                    out.writeBoolean(govt_funded);
                    govt_funded_ndx.put(govt_funded, get_array_list(govt_funded, filepointer, govt_funded_ndx));

                    boolean fda_approved = line[10].equalsIgnoreCase("true");
                    out.writeBoolean(fda_approved);
                    fda_approved_ndx.put(fda_approved, get_array_list(fda_approved, filepointer, fda_approved_ndx));

                }
            }

            write_indices(id_ndx, index_files[0]);
            write_indices(company_ndx, index_files[1]);
            write_indices(drug_id_ndx, index_files[2]);
            write_indices(trials_ndx, index_files[3]);
            write_indices(patients_ndx, index_files[4]);
            write_indices(dosage_mg_ndx, index_files[5]);
            write_indices(reading_ndx, index_files[6]);
            write_indices(double_blind_ndx, index_files[7]);
            write_indices(controlled_study_ndx, index_files[8]);
            write_indices(govt_funded_ndx, index_files[9]);
            write_indices(fda_approved_ndx, index_files[10]);

        } catch (Exception e) {
            System.err.println("Exception in index creation: " + e);
        }
    }

    private int get_operation() {
        int operation = 0;
        do {
            if (operation != 0) {
                System.out.println("Invalid option selected\n Please select the correct option");
            }
            System.out.println("1. Equal (==)\n2. Strictly Greater (>)\n3. Strictly Lesser (<)\n4. Greater or Equal (>=)\n5. Lesser or Equal (<=)");
            operation = Integer.parseInt(read_value());
        } while ((operation > 5 || operation < 1));
        return operation;
    }

    private void display_binary_file(ArrayList<Long> filepointer) throws Exception {
        if (filepointer.isEmpty()) {
            System.out.println("No Records found");
        } else {
            RandomAccessFile tmp = new RandomAccessFile(bin_path, "r");
            for (Long fp : filepointer) {
                tmp.seek(fp);
                int no = tmp.readInt();
                int len = tmp.readInt();
                String str1 = new String();
                String str2 = new String();
                for (int j = 0; j < len; j++) {
                    str1 = str1 + tmp.readChar();
                }
                for (int j = 0; j < 6; j++) {
                    str2 = str2 + tmp.readChar();
                }
                String record = Integer.toString(no) + "\t" + str1 + "\t" + str2 + "\t" + Short.toString(tmp.readShort()) + "\t" + Short.toString(tmp.readShort()) + "\t" + Short.toString(tmp.readShort()) + "\t" + Float.toString(tmp.readFloat()) + "\t" + Boolean.toString(tmp.readBoolean()) + "\t" + Boolean.toString(tmp.readBoolean()) + "\t" + Boolean.toString(tmp.readBoolean()) + "\t" + Boolean.toString(tmp.readBoolean());
                System.out.println(record);
            }
        }
    }

    private void display_records(int field, int operation, String filter_value) throws Exception {

        TreeMap<Object, ArrayList<Long>> temphash = new TreeMap();
        temphash.clear();

        if (!index_files[field].isFile()) {
            System.err.println("Error Index file missing");
            System.exit(1);
        }
        Properties prop = new Properties();
        prop.load(new FileInputStream(index_files[field]));
        for (Object keys : prop.keySet()) {
            String[] values = prop.get(keys).toString().split(",");
            ArrayList<Long> temp = new ArrayList();
            for (String val : values) {
                temp.add(Long.parseLong(val));
            }
            temphash.put(keys, temp);
        }

        //1. Equal (==)\n2. Strictly Greater (>)\n3. Strictly Lesser (<)\n4. Greater or Equal (>=)\n5. Lesser or Equal (<=)
        switch (operation) {
            case 1:
                if (!temphash.containsKey(filter_value)) {
                    System.out.println(filter_value + " is not found");
                } else {
                    display_binary_file(temphash.get(filter_value));
                }
                break;
            case 2:
                for (Object key : temphash.keySet()) {
                    if (field == 0) {
                        int tmp = Integer.parseInt(key.toString());
                        int cmp = Integer.parseInt(filter_value);
                        if (tmp > cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 3 || field == 4 || field == 5) {
                        short tmp = Short.parseShort(key.toString());
                        short cmp = Short.parseShort(filter_value);
                        if (tmp > cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 6) {
                        float tmp = Float.parseFloat(key.toString());
                        float cmp = Float.parseFloat(filter_value);
                        if (tmp > cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else {
                        display_binary_file(temphash.get(key));
                    }
                }
                break;
            case 3:
                for (Object key : temphash.keySet()) {
                    if (field == 0) {
                        int tmp = Integer.parseInt(key.toString());
                        int cmp = Integer.parseInt(filter_value);
                        if (tmp < cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 3 || field == 4 || field == 5) {
                        short tmp = Short.parseShort(key.toString());
                        short cmp = Short.parseShort(filter_value);
                        if (tmp < cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 6) {
                        float tmp = Float.parseFloat(key.toString());
                        float cmp = Float.parseFloat(filter_value);
                        if (tmp < cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else {
                        display_binary_file(temphash.get(key));
                    }
                }
                break;
            case 4:
                for (Object key : temphash.keySet()) {
                    if (field == 0) {
                        int tmp = Integer.parseInt(key.toString());
                        int cmp = Integer.parseInt(filter_value);
                        if (tmp >= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 3 || field == 4 || field == 5) {
                        short tmp = Short.parseShort(key.toString());
                        short cmp = Short.parseShort(filter_value);
                        if (tmp >= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 6) {
                        float tmp = Float.parseFloat(key.toString());
                        float cmp = Float.parseFloat(filter_value);
                        if (tmp >= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else {
                        display_binary_file(temphash.get(key));
                    }
                }
                break;
            case 5:
                for (Object key : temphash.keySet()) {
                    if (field == 0) {
                        int tmp = Integer.parseInt(key.toString());
                        int cmp = Integer.parseInt(filter_value);
                        if (tmp <= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 3 || field == 4 || field == 5) {
                        short tmp = Short.parseShort(key.toString());
                        short cmp = Short.parseShort(filter_value);
                        if (tmp <= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else if (field == 6) {
                        float tmp = Float.parseFloat(key.toString());
                        float cmp = Float.parseFloat(filter_value);
                        if (tmp <= cmp) {
                            display_binary_file(temphash.get(key));
                        }
                    } else {
                        display_binary_file(temphash.get(key));
                    }
                }
                break;
        }

    }

    private int get_field() {
        int field = 0;
        do {
            if (field != 0) {
                System.out.println("Invalid option selected\n Please select the correct option");
            }
            System.out.println("1. id\n2. company\n3. drug_id\n4. trials\n5. patients\n6. dosage_mg\n7. reading\n8. double_blind\n9. controlled_study\n10. govt_funded\n11. fda_approved\n");
            field = Integer.parseInt(read_value()) - 1;
        } while (field > 11 || field < 0);

        return field;
    }

    private void display_sub_menu(int ch) throws Exception {

        if (ch == 1) // Build the index file here
        {
            build_db();
        }
        if (!bin_path.isFile()) {
            System.out.println("Database binary missing.... \nBuilding a new Database");
            System.out.println("Press Enter to continue");
            read_value();
            build_db();
        }

        int field;
        int operation;
        String filter_value;
        String option;
        do {
            System.out.println("Enter a field to query on:");
            field = get_field();
            switch (field) {
                case 0:
                case 3:
                case 4:
                case 5:
                case 6:
                    operation = get_operation();
                    break;
                default:
                    System.out.println("Performing == operation for the selected field");
                    operation = 1;
                    break;
            }
            System.out.println("Enter the value to filter: ");
            filter_value = read_value();

            display_records(field, operation, filter_value);

            System.out.println("Do you wish to continue? [Y/N]: ");
            option = read_value();
        } while (option.equalsIgnoreCase("Y"));

    }

    public static void main(String[] args) throws Exception {
        // TODO code application logic here
        MyDatabase mydb = new MyDatabase();
        mydb.display_main_menu();
    }
}
