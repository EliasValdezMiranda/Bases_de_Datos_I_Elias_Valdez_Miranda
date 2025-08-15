import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Map;
import java.util.TreeMap;

public class Main
{
    // Logger definido para la escritura de errores en caso de presentarse errores de ejecución.
    private static final Logger logger = Logger.getLogger(Main.class.getName());

    // Ruta relativa del archivo CSV con las colonias.
    static String rutaArchivoCSV = "csvFiles/codigos_postales_hmo.csv";

    // Índice de la posición del codigo postal en cada linea del archivo CSV (Utilizado en un arreglo).
    static int indiceCodigoPostal = 0;

    public static void main(String[] args)
    {
        // Se utilizan las funciones complementarias de la clase "ArchivoCSV" para abrir el archivo csv provisto.
        File coloniasArchivoCSV = ArchivoCSV.AbrirArchivoCSV(rutaArchivoCSV);

        // Se crea un FileReader que será utilizado para leer el archivo anteriormente creado.
        try (FileReader fileReader = new FileReader(coloniasArchivoCSV)) {
            // La estructura de datos utilizada para el almacenamiento de los códigos postales y la cantidad de
            // colonias que comparten tal código es un TreeMap, el que ordena las entradas de acuerdo al valor de
            // las llaves (el código postal). Notese el uso de la clase "Integer" para el valor correspondiente a la
            // llave. Se utiliza el wrapper "Integer" por que Java no acepta el uso de tipos primitivos para TreeMaps.
            TreeMap<String, Integer> CodigoPostalTMap = new TreeMap<>();

            // Un string vacio se crea para almacenar la línea actual que el BufferedReader leerá.
            String lineaCSV;

            // Un BufferedReader es creado, el que utiliza el FileReader para leer el archivo CSV línea por línea.
            // Mientras la línea leida no sea nula, se divide esta en un arreglo de Strings separados por cada coma.
            // Dicho arreglo se utiliza para extraer el código postal de la línea actual utilizando la constante.
            // "indiceCodigoPostal"
            // Si el código postal se encuentra en el TreeMap, se suma 1 al contador del codigo postal apropiado.
            // Si el código postal no se encuentra en el TreeMap, se agrega a este con un valor inicial de 1.
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            while ((lineaCSV = bufferedReader.readLine()) != null) {
                String[] arregloLineaCSV = lineaCSV.split(",");
                String llaveCodigoPostal = arregloLineaCSV[indiceCodigoPostal];
                if (CodigoPostalTMap.containsKey(llaveCodigoPostal)) {
                    CodigoPostalTMap.put(llaveCodigoPostal, CodigoPostalTMap.get(llaveCodigoPostal) + 1);
                    continue;
                }
                CodigoPostalTMap.put(llaveCodigoPostal, 1);
            }

            // Se utiliza un ciclo for-each para imprimir las entradas del TreeMap.
            // Notese el uso de "Map.Entry<String, Integer>" para poder utilizar un ciclo for-each, el que hace el
            // código más facil de leer.
            for (Map.Entry<String, Integer> entrada : CodigoPostalTMap.entrySet()) {
                System.out.print("Código postal: " + entrada.getKey());
                System.out.println(" - Número de asentamientos: " + entrada.getValue());
            }

            // Terminadas las operaciones, se cierra el BufferedReader.
            bufferedReader.close();
        } catch (IOException e) {
            // En caso de encontrar un error, se utiliza un logger para registrar la información.
            logger.log(Level.SEVERE, "¡Error encontrado!", e);
        }
    }
}
