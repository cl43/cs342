import oracle.kv.*;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by cl43 on 5/9/2017.
 */
public class GetOrderItem {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

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
