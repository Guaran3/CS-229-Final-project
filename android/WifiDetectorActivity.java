package wifi.detector;

import java.util.List;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.text.format.*;

public class WifiDetectorActivity extends Activity {
	TextView mainText;
	WifiManager mainWifi;
	WifiReceiver receiverWifi;
	List<ScanResult> wifiList;
	StringBuilder sb = new StringBuilder();
	Time timeRecieved;
	
    @Override
	public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        mainText = (TextView) findViewById(R.id.textview);
        mainWifi = (WifiManager) getSystemService(Context.WIFI_SERVICE);
        
        receiverWifi = new WifiReceiver();
        registerReceiver(receiverWifi, new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
        mainWifi.startScan();
        mainText.setText("\nStarting Scan...\n");
    }

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		menu.add(0, 0, 0, "Refresh");
		return super.onCreateOptionsMenu(menu);
	}

	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		mainWifi.startScan();
		mainText.setText("Starting Scan");
		return super.onMenuItemSelected(featureId, item);
	}

	@Override
	protected void onPause() {
		unregisterReceiver(receiverWifi);
		super.onPause();
	}

	@Override
	protected void onResume() {
		registerReceiver(receiverWifi, new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
		super.onResume();
	}
	
	class WifiReceiver extends BroadcastReceiver {
		@Override
		public void onReceive(Context c, Intent intent) {
			sb = new StringBuilder();
			wifiList = mainWifi.getScanResults();
			timeRecieved.setToNow();
	        for(int i = 0; i < wifiList.size(); i++){
	        	sb.append(new Integer(i+1).toString() + ".");
	        	sb.append((wifiList.get(i)).BSSID);
	        	sb.append((wifiList.get(i)).level);
	        	sb.append(timeRecieved.toString());
	        	sb.append("\n");
	        }
	        mainText.setText(sb);
		}
	}

}