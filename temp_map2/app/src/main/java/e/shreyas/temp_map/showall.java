package e.shreyas.temp_map;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.kosalgeek.android.json.JsonConverter;
import com.kosalgeek.asynctask.AsyncResponse;
import com.kosalgeek.asynctask.PostResponseAsyncTask;

import java.net.ServerSocket;
import java.util.ArrayList;
import java.util.List;

public class showall extends AppCompatActivity implements AsyncResponse {

    ListView lvpost;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_showall);
       lvpost = (ListView)findViewById(R.id.lvpost);

        PostResponseAsyncTask task = new PostResponseAsyncTask(this, this);
        task.execute("http://192.168.137.1/andro_park/post.php?format=json");


    }

    @Override
    public void processFinish(String result) {

//Toast.makeText(this, result, Toast.LENGTH_LONG).show();

       List<post> postlist = new JsonConverter<post>().toList(result, post.class);

        ArrayList<String> titles = new ArrayList<String>();

        for (post value:postlist ){
            titles.add(value.parking_name);

        }

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1,titles);

        lvpost.setAdapter(adapter);
    }
}

