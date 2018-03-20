package e.shreyas.temp_map;

import com.google.gson.annotations.SerializedName;



public class post {

    @SerializedName("parking_id")
    public int parking_id;
    @SerializedName("parking_name")
    public String parking_name;
    @SerializedName("parking_longitude")
    public float parking_longitude;
    @SerializedName("parking_latitude")
    public float parking_latitude;
    @SerializedName("parking_status")
    public int parking_status;
    @SerializedName("parking_slots")
    public int parking_slots;
}
