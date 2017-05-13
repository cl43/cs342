import oracle.kv.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoadDB {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000")); //Creates the kvstore instance.
        load(store); //Passes the kvstore and begins loading.
        System.out.println("Loading complete!");
        store.close();
    }

    public static void load(KVStore store) throws  SQLException{ //Creates the jdbc connection and begins loading tables.
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "cl43", "veggies");
        loadOrder(store, jdbcConnection);
        loadItem(store, jdbcConnection);
        loadOrderItem(store, jdbcConnection);
        jdbcConnection.close();
    }

    public static void loadOrder(KVStore store, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, orderdate, price FROM Order1");
        while (resultSet.next()) {
            Key dateKey = Key.createKey(Arrays.asList("order"), Arrays.asList(resultSet.getString(1),"date"));
            Value dateValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(dateKey, dateValue);

            Key priceKey = Key.createKey(Arrays.asList("order"), Arrays.asList(resultSet.getString(1),"price"));
            Value priceValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(priceKey, priceValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadItem(KVStore store, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, price, stock FROM Item");
        while (resultSet.next()) {
            Key nameKey = Key.createKey(Arrays.asList("item"), Arrays.asList(resultSet.getString(1),"name"));
            Value nameValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(nameKey, nameValue);

            Key priceKey = Key.createKey(Arrays.asList("item"), Arrays.asList(resultSet.getString(1),"price"));
            Value priceValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(priceKey, priceValue);

            Key stockKey = Key.createKey(Arrays.asList("item"), Arrays.asList(resultSet.getString(1),"stock"));
            Value stockValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(stockKey, stockValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadOrderItem(KVStore store, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT orderID, itemID, quantity FROM OrderItem");

        ArrayList<Key> orderKeys = new ArrayList<Key>();
        ArrayList<Key> itemKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> orderValues = new ArrayList<>();
        ArrayList<ArrayList<String>> itemValues = new ArrayList<>();
        while (resultSet.next()) {
            Key orderKey = Key.createKey(Arrays.asList("order", resultSet.getString(1)), Arrays.asList("item", resultSet.getString(2)));
            if(!orderKeys.contains(orderKey)){
                orderKeys.add(orderKey);
                orderValues.add(new ArrayList<>());
            }
            orderValues.get(orderKeys.indexOf(orderKey)).add(resultSet.getString(3));

            Key itemKey = Key.createKey(Arrays.asList("item", resultSet.getString(2)), Arrays.asList("order", resultSet.getString(2)));
            if(!itemKeys.contains(itemKey)){
                itemKeys.add(itemKey);
                itemValues.add(new ArrayList<>());
            }
            itemValues.get(itemKeys.indexOf(itemKey)).add(resultSet.getString(3));

            for (int i = 0; i < itemKeys.size(); i++) {
                String getI = itemValues.get(i).toString();
                Value value = Value.createValue(getI.getBytes());
                store.put(itemKeys.get(i), value);
            }
            for (int i = 0; i < orderKeys.size(); i++) {
                String getI = orderValues.get(i).toString();
                Value value = Value.createValue(getI.getBytes());
                store.put(orderKeys.get(i), value);
            }
        }
        resultSet.close();
        jdbcStatement.close();
    }

}