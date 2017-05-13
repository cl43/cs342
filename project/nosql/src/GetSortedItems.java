import oracle.kv.*;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by cl43 on 5/10/2017.
 */
public class GetSortedItems {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    public static void output(KVStore store) {
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("item"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        HashMap<String, ArrayList<String>> items = new HashMap<>();
        ArrayList<String> prices = new ArrayList<>();
        String name = " ", price = " ";
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String id = field.getKey().getMinorPath().get(0);
            if (field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            }
            if (field.getKey().getMinorPath().get(1).equals("price")) {
                price = new String(field.getValue().getValue().getValue());
            }
            if (!items.containsKey(price)) {
                items.put(price, new ArrayList<>());
                prices.add(price);
            }
            items.get(price).add(id + "\t" + name);
        }
        Collections.sort(prices);
        for (String myPrice : prices) {
            for (String item : items.get(myPrice)) {
                System.out.println(myPrice + "\t" + item);
            }
        }
    }
}