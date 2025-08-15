import java.io.File;

public class ArchivoCSV {
    /**
     * Llama al metodo sobrecargado AbrirArchivoCSV() con un parametro de debug adicional.
     *
     * @param ruta La ruta esperada del documento csv por abrir.
     * @return Archivo CSV en tipo File.
     */
    public static File AbrirArchivoCSV(String ruta)
    {
        return AbrirArchivoCSV(ruta, "src/" + ruta);
    }

    /**
     * Revisa la existencia y capacidad de leer el archivo CSV.
     * De no encontrar ningun problema, regresa el archivo CSV.
     *
     * @param ruta La ruta esperada del documento csv por abrir.
     * @param rutaDebug Una ruta basada en la raíz del proyecto necesaria al trabajar con el programa en el IDE.
     * @return Archivo CSV en tipo File.
     */
    private static File AbrirArchivoCSV(String ruta, String rutaDebug)
    {
        File csvFile = new File(ruta);
        csvFile = csvFile.exists() ? csvFile : new File(rutaDebug);
        if (!csvFile.exists())
        {
            System.out.println("Archivo CSV no encontrado.");
            System.exit(1);
        }
        else if (!csvFile.canRead())
        {
            System.out.println("Archivo CSV no se puede leer.");
            System.exit(2);
        }
        return csvFile;
    }
}
