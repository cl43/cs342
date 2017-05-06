/**
 * Created by cl43 on 5/5/2017.
 */
import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

public class HelloRecords {

    public static void main(String[] args) {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
        Value value = Value.createValue("Dr. Strangelove".getBytes());
        store.put(key, value);
        String result = new String(store.get(key).getValue().getValue());
        System.out.println(key.toString() + " : " + result);

        Key key2 = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
        Value value2 = Value.createValue("1964".getBytes());
        store.put(key2, value2);
        String result2 = new String(store.get(key2).getValue().getValue());
        System.out.println(key2.toString() + " : " + result2);

        Key key3 = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rating"));
        Value value3 = Value.createValue("8.7".getBytes());
        store.put(key3, value3);
        String result3 = new String(store.get(key3).getValue().getValue());
        System.out.println(key3.toString() + " : " + result3);

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }

        store.close();
    }
}
