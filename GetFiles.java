import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
public class GetFiles {

	/**
	 * @param args
	 */
	
	public static void main(String[] args) throws UnsupportedEncodingException, FileNotFoundException, IOException {
		// TODO Auto-generated method stub
		int count = 0;
		File file = new File("C:/Users/Vineet/WINLAB/N20-1");
		File[] listFiles = file.listFiles();
		try (Writer writer = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream("C:/Users/Vineet/WINLAB/N20-1/files.txt"),"utf-8"))){
			//BufferedWriter buffer = new BufferedWriter(writer);
			String numOfFiles = Integer.toString(listFiles.length);
			writer.write(numOfFiles);
			writer.write(System.lineSeparator());
			for (int i = 0; i < listFiles.length; i++){
				writer.write(listFiles[i].getAbsolutePath());
				writer.write(System.lineSeparator());
				count++;
			}
			writer.close();
		}
		System.out.println(count);
	}
	
}


