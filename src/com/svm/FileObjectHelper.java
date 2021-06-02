/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.svm;

//import com.constants.ServerConstants;
import com.helper.StringHelper;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author technowings
 */
public class FileObjectHelper {
    
    public static void saveObject(Object object, String fileName) {
        FileOutputStream fos = null;
        try {
            File f = new File(fileName);
            System.out.println(f.getCanonicalPath());
            fos = new FileOutputStream(f);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(object);
            oos.flush();
            oos.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                fos.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    public static HashMap readHashMap(String fileName) {
        FileInputStream fis = null;
        try {
            File f = new File(fileName);
            System.out.println(f.getCanonicalPath());
            if (f.exists()) {
                System.out.println(f.getCanonicalPath());
                fis = new FileInputStream(f);
                ObjectInputStream oos = new ObjectInputStream(fis);
                Object o = oos.readObject();
                if (o != null) {
                    HashMap map = (HashMap) o;
                    return map;
                }
            } else {
                System.err.println("File does not exist " + f.getCanonicalPath());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    public static void writeFile(ArrayList list) throws IOException {
//        BufferedWriter bw = new BufferedWriter(new FileWriter("D:/feature.csv"));
        StringBuffer sb=new StringBuffer();
        FileWriter writer = writer = new FileWriter("D:/feature.csv");;
             for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i)+",");
        }        
        writer.write(sb.toString());
        writer.flush();

    }
    public static Object readObject(String fileName) {
        FileInputStream fis = null;
        try {
            File f = new File(fileName);
            System.out.println(f.getCanonicalPath());
            if (f.exists()) {
                System.out.println(f.getCanonicalPath());
                fis = new FileInputStream(f);
                ObjectInputStream oos = new ObjectInputStream(fis);
                Object o = oos.readObject();
                return o;
            } else {
                System.err.println("File does not exist " + f.getCanonicalPath());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
