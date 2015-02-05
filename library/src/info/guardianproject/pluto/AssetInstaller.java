/* Copyright (c) 2009, Nathan Freitas, Orbot / The Guardian Project - http://openideals.com/guardian */
/* See LICENSE for licensing information */

package info.guardianproject.pluto;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import android.content.Context;
import android.util.Log;

public class AssetInstaller {

	
	private File installFolder;
	private Context context;
	
	private final static String TAG = "PLUTO";

	private final static int FILE_WRITE_BUFFER_SIZE = 1024;
	private final static String CHMOD_EXE_VALUE = "770";
	private final static String COMMAND_RM_FORCE = "rm -f ";
	
	public AssetInstaller (Context context, File installFolder)
	{
		this.installFolder = installFolder;	
		this.context = context;
	}
	
	public boolean installBinary (String assetPath) throws Exception
	{
		
		InputStream is = null;
        File outFile;
        
        installFolder.mkdirs();
        
        String ptAsset = null;
        
		//is = context.getResources().openRawResource(R.raw.obfsclient);
		
		outFile = new File(installFolder, ptAsset);
		//shell.add(new SimpleCommand(COMMAND_RM_FORCE + outFile.getAbsolutePath())).waitForFinish();
		streamToFile(is,outFile, false, true);
		
		enableBinExec (outFile);
		
		return true;
	}
	
	private boolean enableBinExec (File fileBin) throws Exception
    {
  
    	if (!fileBin.canExecute())
    	{
			
			//shell.add(new SimpleCommand("chmod " + CHMOD_EXE_VALUE + ' ' + fileBin.getCanonicalPath())).waitForFinish();
			
			File fileTest = new File(fileBin.getCanonicalPath());
			
    	}
    	
		return fileBin.canExecute();
    }
	
	
	/*
	 * Write the inputstream contents to the file
	 */
    public static boolean streamToFile(InputStream stm, File outFile, boolean append, boolean zip) throws IOException

    {
        byte[] buffer = new byte[FILE_WRITE_BUFFER_SIZE];

        int bytecount;

    	OutputStream stmOut = new FileOutputStream(outFile.getAbsolutePath(), append);
    	ZipInputStream zis = null;
    	
    	if (zip)
    	{
    		zis = new ZipInputStream(stm);    		
    		ZipEntry ze = zis.getNextEntry();
    		stm = zis;
    		
    	}
    	
        while ((bytecount = stm.read(buffer)) > 0)
        {

            stmOut.write(buffer, 0, bytecount);

        }

        stmOut.close();
        stm.close();
        
        if (zis != null)
        	zis.close();
        
        
        return true;

    }
	
    //copy the file from inputstream to File output - alternative impl
	public static void copyFile (InputStream is, File outputFile)
	{
		
		try {
			outputFile.createNewFile();
			DataOutputStream out = new DataOutputStream(new FileOutputStream(outputFile));
			DataInputStream in = new DataInputStream(is);
			
			int b = -1;
			byte[] data = new byte[1024];
			
			while ((b = in.read(data)) != -1) {
				out.write(data);
			}
			
			if (b == -1); //rejoice
			
			//
			out.flush();
			out.close();
			in.close();
			// chmod?
			
			
			
		} catch (IOException ex) {
			Log.e(TAG, "error copying binary", ex);
		}

	}
	
	

   
	/**
	 * Copies a raw resource file, given its ID to the given location
	 * @param ctx context
	 * @param resid resource id
	 * @param file destination file
	 * @param mode file permissions (E.g.: "755")
	 * @throws IOException on error
	 * @throws InterruptedException when interrupted
	 */
	public static void copyRawFile(Context ctx, int resid, File file, String mode, boolean isZipd) throws IOException, InterruptedException
	{
		final String abspath = file.getAbsolutePath();
		// Write the iptables binary
		final FileOutputStream out = new FileOutputStream(file);
		InputStream is = ctx.getResources().openRawResource(resid);
		
		if (isZipd)
    	{
    		ZipInputStream zis = new ZipInputStream(is);    		
    		ZipEntry ze = zis.getNextEntry();
    		is = zis;
    	}
		
		byte buf[] = new byte[1024];
		int len;
		while ((len = is.read(buf)) > 0) {
			out.write(buf, 0, len);
		}
		out.close();
		is.close();
		// Change the permissions
		Runtime.getRuntime().exec("chmod "+mode+" "+abspath).waitFor();
	}
   
	

}
