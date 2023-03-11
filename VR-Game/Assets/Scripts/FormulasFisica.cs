using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Formulas
{
    public static float Distance(Vector3 a, Vector3 b)
    {
        float x = Mathf.Pow((b.x - a.x), 2); // Restar x_b - x_a y elevarlo al cuadrado
        float y = Mathf.Pow((b.y - a.y), 2); // Restar y_b - y_a y elevarlo al cuadrado
        float z = Mathf.Pow((b.z - a.z), 2); // Restar z_b - z_a y elevarlo al cuadrado
        float distance = Mathf.Sqrt(x + y + z);
        Debug.Log("Distance: "+distance);
        return distance;
    }

    public float Magnitud(Vector3 a)
    {
        float x = Mathf.Pow(a.x, 2);
        float y = Mathf.Pow(a.y, 2);
        float z = Mathf.Pow(a.z, 2);

        return Mathf.Sqrt(x + y + z);
    }

    public Vector3 Normalizar(Vector3 a)
    {
        float mag = Magnitud(a);

        return a / mag;
    }

    public float ProductoPunto(Vector3 a, Vector3 b)
    {
        float result;
        Vector3 producto;
        producto = new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);

        return result = producto.x + producto.y + producto.z;
    }

    public Vector3 ProductoCruz(Vector3 a, Vector3 b)
    {
        Vector3 resultado;

        resultado.x = (a.y * b.z) - (b.y * a.z);
        resultado.y = (-1) * ((a.x * b.z) - (b.x * a.z));
        resultado.z = (a.x * b.y) - (b.x * a.y);

        return resultado;
    }

    public Vector3 MovimientoDeMatriz(Vector3 ubicacion, Vector3 delta)
    {
        Vector3 ubicacionActualizada = ubicacion + delta;

        return ubicacionActualizada;
    }

    public Vector3 MovimientoDeMatrices(Vector3 ubicacion, Vector3 delta)
    {
        Vector3 ubicacionActualizada;
        Vector4 x = new Vector4(1, 0, 0, 0);
        Vector4 y = new Vector4(0, 1, 0, 0);
        Vector4 z = new Vector4(0, 0, 1, 0);
        Vector4 VectorDelta = new Vector4(delta.x, delta.y, delta.z, 1);
        Vector4 vectorUbicacion = new Vector4(ubicacion.x, ubicacion.y, ubicacion.z, 1);

        Matrix4x4 matrizUbicacion = new Matrix4x4(x, y, z, delta);
        ubicacionActualizada = matrizUbicacion * vectorUbicacion;

        return ubicacionActualizada;
    }

    public Vector3 RotacionDeMatrizX(Vector3 ubicacionActual, float angle)
    {
        Vector3 ubicacionActualizada;

        Vector4 x = new Vector4(1, 0, 0, 0);
        Vector4 y = new Vector4(0, Mathf.Cos(angle), (-1) * Mathf.Sin(angle), 0);
        Vector4 z = new Vector4(0, Mathf.Sin(angle), Mathf.Cos(angle), 0);
        Vector4 VectorAgregado = new Vector4(0, 0, 0, 1);
        Vector4 vectorUbicacion = new Vector4(ubicacionActual.x, ubicacionActual.y, ubicacionActual.z, 1);
        Matrix4x4 MatrizBase = new Matrix4x4(x, y, z, VectorAgregado);

        ubicacionActualizada = MatrizBase * vectorUbicacion;

        return ubicacionActualizada;
    }

    public Vector3 RotacionDeMatrizY(Vector3 ubicacionActual, float angle)
    {
        Vector3 ubicacionActualizada;

        Vector4 x = new Vector4(Mathf.Cos(angle), 0, Mathf.Sin(angle), 0);
        Vector4 y = new Vector4(0, 1, 0, 0);
        Vector4 z = new Vector4((-1) * Mathf.Sin(angle), 0, Mathf.Cos(angle), 0);
        Vector4 VectorAgregado = new Vector4(0, 0, 0, 1);
        Vector4 vectorUbicacion = new Vector4(ubicacionActual.x, ubicacionActual.y, ubicacionActual.z, 1);
        Matrix4x4 MatrizBase = new Matrix4x4(x, y, z, VectorAgregado);

        ubicacionActualizada = MatrizBase * vectorUbicacion;

        return ubicacionActualizada;
    }

    public Vector3 RotacionDeMatrizZ(Vector3 ubicacionActual, float angle)
    {
        Vector3 ubicacionActualizada;

        Vector4 x = new Vector4(Mathf.Cos(angle), (-1) * Mathf.Sin(angle), 0, 0);
        Vector4 y = new Vector4(Mathf.Sin(angle), Mathf.Cos(angle), 0, 0);
        Vector4 z = new Vector4(0, 0, 1, 0);
        Vector4 VectorAgregado = new Vector4(0, 0, 0, 1);
        Vector4 vectorUbicacion = new Vector4(ubicacionActual.x, ubicacionActual.y, ubicacionActual.z, 1);
        Matrix4x4 MatrizBase = new Matrix4x4(x, y, z, VectorAgregado);

        ubicacionActualizada = MatrizBase * vectorUbicacion;

        return ubicacionActualizada;
    }

    public static float DotProduct(Vector3 point1, Vector3 point2)
    {
        float distancePoint1 = point1.x * point2.x + point1.y * point2.y + point1.z * point2.z;
        Debug.Log("Sum: " +distancePoint1);
        return distancePoint1;

    }
}
