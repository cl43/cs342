import oracle.kv.*;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by cl43 on 5/10/2017.
 */
public class GetSortedItems {

    /*Main function that loads the database and then prints out the values for orderItem*/
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    /*Creates a key with item as a major key. There are no minor keys in this key path. Kvstore performs a multi-get to retrieve the
    *values. A hashMap and arrayList is created in order to help perform the sorting. hashMap makes it easier to check the price through
    * the queries. While arraylist, stores the tuple entries in order of price. The fields grab the value of the name and price,
    * sorts it and then sticks it into a string array for printing. */
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