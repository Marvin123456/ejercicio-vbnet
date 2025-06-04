Imports MySql.Data.MySqlClient

Public Class ClaseConexion
    Private Shared cadenaConexion As String = "server=localhost;port=3306;database=pruebatecnica;user=usuarioprueba;password=Tecnica+0306;SslMode=none"

    Public Shared Function ObtenerConexion() As MySqlConnection
        Return New MySqlConnection(cadenaConexion)
    End Function
End Class
