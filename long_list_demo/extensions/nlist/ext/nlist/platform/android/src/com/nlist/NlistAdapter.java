package com.nlist;

import java.io.File;
import java.util.ArrayList;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.rhomobile.rhodes.R;
import com.rhomobile.rhodes.RhodesService;
import com.rhomobile.rhodes.file.RhoFileApi;
import com.rhomobile.rhodes.util.Utils;

import com.rhomobile.rhodes.extmanager.RhoExtManager;

public class NlistAdapter extends BaseAdapter {

	private int mCount = 0;

	private NlistDataCache mDataCache = null;

    public NlistAdapter(int count, NlistDataCache dataCache) {
            super();
            mCount = count;
            mDataCache = dataCache;
    }
    
    
	public int getCount() {
		return mCount;
	}

	public Object getItem(int position) {
		return null;
	}
	
	public long getItemId(int position) {
	     return position;
	}
    

    public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if (v == null) {
                LayoutInflater vi = (LayoutInflater)RhodesService.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = vi.inflate(RhoExtManager.getResourceId("layout", "row"), null);
        		v.setBackgroundColor(0xFF707070);

            }
            TextView tt = (TextView) v.findViewById(RhoExtManager.getResourceId("id", "toptext"));
            TextView bt = (TextView) v.findViewById(RhoExtManager.getResourceId("id", "bottomtext"));
            TextView numberText = (TextView) v.findViewById(RhoExtManager.getResourceId("id", "numbertext"));
            ImageView iv = (ImageView)v.findViewById(RhoExtManager.getResourceId("id", "itemimage"));
            
            NlistData data = mDataCache.getData(position); 
            
        	if (data != null) {
                if (tt != null) {
                    tt.setText(data.getTitle());                            
                }
        	    else {
        	        com.rhomobile.rhodes.util.Utils.platformLog("NLIST", "$$$$$$$$$   tt == null");
        	    }
                if(bt != null){
                    bt.setText(data.getSubtitle());
                }
                if(numberText != null){
             		numberText.setText(data.getNumber());
                }
                if (iv != null) {
                	iv.setImageBitmap(null);
                	Bitmap bitmap = BitmapFactory.decodeStream(RhoFileApi.open(data.getImage()));
                	if (bitmap != null) {
                		bitmap.setDensity(DisplayMetrics.DENSITY_MEDIUM); 
                    	iv.setImageBitmap(bitmap);
                	}
                }
        	    else {
        	        com.rhomobile.rhodes.util.Utils.platformLog("NLIST", "$$$$$$$$$   iv == null");
        	    }
        	}
        	else {
        	    com.rhomobile.rhodes.util.Utils.platformLog("NLIST", "$$$$$$$$$   data == null");
        	}
            v.requestLayout();
            v.invalidate();
            return v;
    }

	
}
