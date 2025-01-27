package eu.sttlab;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.ArrayList;
import java.util.List;
// --- <<IS-END-IMPORTS>> ---

public final class java

{
	// ---( internal utility methods )---

	final static java _instance = new java();

	static java _newInstance() { return new java(); }

	static java _cast(Object o) { return (java)o; }

	// ---( server methods )---




	public static final void allocateMemory (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(allocateMemory)>> ---
		// @sigtype java 3.5
		// [i] field:0:required memoryMb
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	memoryMb = IDataUtil.getString( pipelineCursor, "memoryMb" );
		String	delayMillis = IDataUtil.getString( pipelineCursor, "delayMillis" );
		pipelineCursor.destroy();
		
		List<byte[]> memoryConsumers = new ArrayList<>();
		try {
			memoryConsumers.add(new byte[Integer.parseInt(memoryMb) * 1024 * 1024]); 
			Thread.sleep(Long.parseLong(delayMillis));
		} catch (Exception e) {
		    throw new ServiceException(e);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void fibonacci (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(fibonacci)>> ---
		// @sigtype java 3.5
		// [i] field:0:required n
		// [o] field:0:required result
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	n = IDataUtil.getString( pipelineCursor, "n" );
		pipelineCursor.destroy();
		
		long resultat = fibonacciCalc(Integer.parseInt(n));
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "result", Long.toString(resultat) );
		pipelineCursor_1.destroy();
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void waitJava (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(waitJava)>> ---
		// @sigtype java 3.5
		// [i] field:0:required delayMillis
		
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	delayMillis = IDataUtil.getString( pipelineCursor, "delayMillis" );
		pipelineCursor.destroy();
		// pipeline
		
		try {
			Thread.sleep(Long.parseLong(delayMillis));
		} catch (Exception e) {
			throw new ServiceException(e);
		}
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static long fibonacciCalc(int n) {
	    if (n <= 1) return n;
	    return fibonacciCalc(n-1) + fibonacciCalc(n-2);
	}
	
		
	// --- <<IS-END-SHARED>> ---
}

