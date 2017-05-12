import oracle.kv.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 * This program used JDBC to query all the movies from the IMDB Movies table.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 *
 * @author kvlinden
 * @version Spring, 2015
 */
public class LoadDB {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000")); //Creates the kvstore instance.
        load(store); //Passes the kvstore and begins loading.
        System.out.println("Loading complete!");
        store.close();
    }

    public static void load(KVStore store) throws  SQLException{ //Creates the jdbc connection and begins loading tables.
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        loadMovie(store, jdbcConnection);
        loadActor(store, jdbcConnection);
        loadRole(store, jdbcConnection);
        jdbcConnection.close();
    }

    public static void loadMovie(KVStore store, Connection jdbcConnection) throws SQLException{ //Loading Movie Values
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie"); //Result set from query.
        while (resultSet.next()) {
            Key nameKey = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultSet.getString(1),"name")); //The key structure is similar to the one presented in the lab. Movie being the major key and name as the minor key.
            Value nameValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(nameKey, nameValue);

            Key yearKey = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultSet.getString(1),"year"));//Year is minor key
            Value yearValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(yearKey, yearValue);

            Key rankKey = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultSet.getString(1),"rank"));//Rank is minor key
            Value rankValue = Value.createValue("".getBytes());
            if (rankValue != null) { //Grabs bytes for a non null value
                rankValue = Value.createValue(resultSet.getString(3).getBytes());
            }
            store.put(rankKey, rankValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadActor(KVStore store, Connection jdbcConnection) throws SQLException{//Loading Actor Values
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Actor");
        while (resultSet.next()) {
            Key fNameKey = Key.createKey(Arrays.asList("actor"), Arrays.asList(resultSet.getString(1),"firstname"));//Major key actor, mimor key firstName
            Value fNameValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(fNameKey, fNameValue);

            Key lNameKey = Key.createKey(Arrays.asList("actor"), Arrays.asList(resultSet.getString(1),"lastname"));//Minor key lastName
            Value lNameValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(lNameKey, lNameValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadRole(KVStore store, Connection jdbcConnection) throws SQLException{//Loading Role Values
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT actorid, movieid, role FROM Role");

        ArrayList<Key> movieKeys = new ArrayList<Key>();
        ArrayList<Key> actorKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> movieValues = new ArrayList<>();
        ArrayList<ArrayList<String>> actorValues = new ArrayList<>();
        while (resultSet.next()) {
            Key movieKey = Key.createKey(Arrays.asList("Movie", resultSet.getString(1)), Arrays.asList("Actor", resultSet.getString(2)));// Movie is major key, actor is minor key.
            if(!movieKeys.contains(movieKey)){
                movieKeys.add(movieKey);
                movieValues.add(new ArrayList<>());
            }
            movieValues.get(movieKeys.indexOf(movieKey)).add(resultSet.getString(3));

            Key actorKey = Key.createKey(Arrays.asList("Actor", resultSet.getString(2)), Arrays.asList("Movie", resultSet.getString(2)));//Actor is major key here, Movie is minor.
            if(!actorKeys.contains(actorKey)){
                actorKeys.add(actorKey);
                actorValues.add(new ArrayList<>());
            }
            actorValues.get(actorKeys.indexOf(actorKey)).add(resultSet.getString(3));

            for (int i = 0; i < actorKeys.size(); i++) {
                String getI = actorValues.get(i).toString();
                Value value = Value.createValue(getI.getBytes());
                store.put(actorKeys.get(i), value);
            }
            for (int i = 0; i < movieKeys.size(); i++) {
                String getI = movieValues.get(i).toString();
                Value value = Value.createValue(getI.getBytes());
                store.put(movieKeys.get(i), value);
            }
        }
        resultSet.close();
        jdbcStatement.close();
    }

}