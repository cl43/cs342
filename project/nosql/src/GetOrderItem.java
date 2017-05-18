import oracle.kv.*;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by cl43 on 5/9/2017.
 */
public class GetOrderItem {

    /*Main function that loads the database and then prints out the values for orderItem*/
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    /*Creates a key with order as a major key, but it specifically looks for order with id = 1. items is the minor key here
    * kvstore performs a multi-get to retrieve the values that correspond to what the key requests for. Afterwards, another key
    * is created where item is the major key, but looks for the input argument of itemid. It then assigns values by searching for the
    * name and price before sticking it into a string array for printing*/
    public static void output(KVStore store){
        System.out.println("Order ID: 1");
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("order", "1"), Arrays.asList("items"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        String fieldName = " ", fieldPrice = " ";
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String itemid = field.getKey().getMinorPath().get(1);
            Key actorKey = Key.createKey(Arrays.asList("item", itemid));
            Map<Key, ValueVersion> actorField = store.multiGet(actorKey, null, null);
            for (Map.Entry<Key, ValueVersion> field2 : actorField.entrySet()) {
                if(field2.getKey().getMinorPath().get(0).equals("name")){
                    fieldName = new String(field2.getValue().getValue().getValue());
                }
                if(field2.getKey().getMinorPath().get(0).equals("price")){
                    fieldPrice = new String(field2.getValue().getValue().getValue());
                }
            }
            String[] quantityArray = new String(field.getValue().getValue().getValue()).split(": ");
            for(String quantity : quantityArray) {
                System.out.println("\t" + itemid + "\t: " + fieldName + " " + fieldPrice + "\t: " + quantity);
            }
        }
    }
}
