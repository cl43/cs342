import oracle.kv.*;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by cl43 on 5/10/2017.
 */
public class GetSortedMovies {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    public static void output(KVStore store) {
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        HashMap<String, ArrayList<String>> movies = new HashMap<>();
        ArrayList<String> years = new ArrayList<>();
        String name = " ", year = " ";
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String id = field.getKey().getMinorPath().get(0);
            if (field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            }
            if (field.getKey().getMinorPath().get(1).equals("year")) {
                year = new String(field.getValue().getValue().getValue());
            }
            if (!movies.containsKey(year)) {
                movies.put(year, new ArrayList<>());
                years.add(year);
            }
            movies.get(year).add(id + "\t" + name);
        }
        Collections.sort(years);
        for (String myear : years) {
            for (String movie : movies.get(myear)) {
                System.out.println(myear + "\t" + movie);
            }
        }
    }
}

