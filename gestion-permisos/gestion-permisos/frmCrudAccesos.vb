Imports System.Runtime.CompilerServices
Imports MySql.Data.MySqlClient

Public Class frm_crud_accesos

    ' Carga de informacion de los usuarios (tabla Personal)

    Private Sub CargarUsuarios()
        Try
            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

            Dim comando As New MySqlCommand("SELECT per_codigo AS USUARIO_COD, per_usuario AS USUARIO FROM PERSONAL", conexion)
            Dim adaptador As New MySqlDataAdapter(comando)
            Dim dtUsuarios As New DataTable()
            adaptador.Fill(dtUsuarios)

            cbUsuario.DisplayMember = "USUARIO"
            cbUsuario.ValueMember = "USUARIO_COD"
            cbUsuario.DataSource = dtUsuarios

            cbUsuario.SelectedIndex = -1
            conexion.Close()
        Catch ex As Exception
            MessageBox.Show("Error al cargar usuarios: " & ex.Message)
        End Try
    End Sub

    'Cargar información de los programas
    Private Sub CargarProgramas()
        Try
            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

            Dim comando As New MySqlCommand("SELECT pro_codigo AS PROGRAMA_COD, pro_descripcion PROGRAMA FROM PROGRAMAS", conexion)
            Dim adaptador As New MySqlDataAdapter(comando)
            Dim dtProgramas As New DataTable()
            adaptador.Fill(dtProgramas)

            cbListaProgramas.DisplayMember = "PROGRAMA"
            cbListaProgramas.ValueMember = "PROGRAMA_COD"
            cbListaProgramas.DataSource = dtProgramas

            cbListaProgramas.SelectedIndex = -1
            conexion.Close()
        Catch ex As Exception
            MessageBox.Show("Error al cargar programas: " & ex.Message)
        End Try
    End Sub

    'Cargar listado de accesos ya concedidos a los usuarios
    Private Sub CargarPermisos()
        Try
            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

             Dim consulta = "
                    SELECT 
                      A.seg_per_codigo AS USUARIO_COD, 
                      P.per_usuario AS USUARIO, 
                      A.seg_pro_codigo AS PROGRAMA_COD, 
                      PR.pro_descripcion AS PROGRAMA, 

                      A.seg_insertar AS CREAR_C, 
                      IF(A.seg_insertar = 1, 'SI', 'NO') AS CREAR,

                      A.seg_editar AS ACTUALIZAR_C, 
                      IF(A.seg_editar = 1, 'SI', 'NO') AS ACTUALIZAR,

                      A.seg_borrar AS ELIMINAR_C, 
                      IF(A.seg_borrar = 1, 'SI', 'NO') AS ELIMINAR,

                      A.seg_buscar AS LEER_C, 
                      IF(A.seg_buscar = 1, 'SI', 'NO') AS LEER

                    FROM ACCESOS A
                    INNER JOIN PERSONAL P ON A.seg_per_codigo = P.per_codigo
                    INNER JOIN PROGRAMAS PR ON A.seg_pro_codigo = PR.pro_codigo"
            Dim adaptador As New MySqlDataAdapter(consulta, conexion)
            Dim tabla As New DataTable()
            adaptador.Fill(tabla)
            dgvAccesos.DataSource = tabla
            dgvAccesos.Columns("USUARIO_COD").Visible = False
            dgvAccesos.Columns("PROGRAMA_COD").Visible = False
            dgvAccesos.Columns("CREAR_C").Visible = False
            dgvAccesos.Columns("ACTUALIZAR_C").Visible = False
            dgvAccesos.Columns("ELIMINAR_C").Visible = False
            dgvAccesos.Columns("LEER_C").Visible = False
            conexion.Close()
        Catch ex As Exception
            MessageBox.Show("Error al cargar programas: " & ex.Message)
        End Try
    End Sub

    Private Sub frm_crud_accesos_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CargarUsuarios()
        CargarProgramas()
        CargarPermisos()
    End Sub

    Private Sub dgvAccesos_CellClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgvAccesos.CellClick
        If dgvAccesos.SelectedRows.Count > 0 Then
            Dim fila As DataGridViewRow = dgvAccesos.SelectedRows(0)
            If Not IsDBNull(fila.Cells("USUARIO_COD").Value) AndAlso Not IsDBNull(fila.Cells("PROGRAMA_COD").Value) Then
                Dim usuarioId As Integer = CInt(fila.Cells("USUARIO_COD").Value)
                Dim programaId As Integer = CInt(fila.Cells("PROGRAMA_COD").Value)
                cbUsuario.SelectedValue = usuarioId
                cbListaProgramas.SelectedValue = programaId

                cbxCrear.Checked = (fila.Cells("CREAR_C").Value.ToString() = "1")
                cbxActualizar.Checked = (fila.Cells("ACTUALIZAR_C").Value.ToString() = "1")
                cbxEliminar.Checked = (fila.Cells("ELIMINAR_C").Value.ToString() = "1")
                cbxLeer.Checked = (fila.Cells("LEER_C").Value.ToString() = "1")
            End If
        End If
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        'Recuperar los valores seleccionados del formulario
        Dim usuario As Integer = Convert.ToInt32(cbUsuario.SelectedValue)
        Dim programa As Integer = Convert.ToInt32(cbListaProgramas.SelectedValue)
        Dim crear = cbxCrear.Checked
        Dim leer = cbxLeer.Checked
        Dim actualizar = cbxActualizar.Checked
        Dim eliminar = cbxEliminar.Checked

        Try
            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

            ' Revisa si ya existe un registro previo, es decir una relación entre el usuario y el programa
            Dim consulta = "SELECT COUNT(*) FROM ACCESOS WHERE seg_per_codigo = @usuario AND seg_pro_codigo = @programa"
            Dim cmdVerifica = New MySqlCommand(consulta, conexion)
            cmdVerifica.Parameters.AddWithValue("@usuario", usuario)
            cmdVerifica.Parameters.AddWithValue("@programa", programa)

            Dim existe As Integer = Convert.ToInt32(cmdVerifica.ExecuteScalar())

            If existe = 0 Then
                ' Si no existe agrega el nuevo acceso a la tabla
                Dim insert = "INSERT INTO ACCESOS (seg_per_codigo, seg_pro_codigo, seg_insertar, seg_editar, seg_borrar, seg_buscar) 
                          VALUES (@usuario, @programa, @crear, @actualizar, @eliminar, @leer)"
                Dim cmdInsert = New MySqlCommand(insert, conexion)
                cmdInsert.Parameters.AddWithValue("@usuario", usuario)
                cmdInsert.Parameters.AddWithValue("@programa", programa)
                cmdInsert.Parameters.AddWithValue("@crear", crear)
                cmdInsert.Parameters.AddWithValue("@actualizar", actualizar)
                cmdInsert.Parameters.AddWithValue("@eliminar", eliminar)
                cmdInsert.Parameters.AddWithValue("@leer", leer)
                cmdInsert.ExecuteNonQuery()
                MessageBox.Show("Permisos guardados correctamente.")
            Else
                ' Si el acceso existe se actualiza la información segun los valores agregados
                MessageBox.Show("El usuario ya cuenta con acceso al programa seleccionado")

            End If

            conexion.Close()
            CargarPermisos()

        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try
    End Sub

    Private Sub btnEditar_Click(sender As Object, e As EventArgs) Handles btnEditar.Click
        Try
            ' Validar que se haya seleccionado un elemento en el DataGridView
            If dgvAccesos.SelectedRows.Count = 0 Then
                MessageBox.Show("Selecciona un registro para editar.")
                Exit Sub
            End If

            ' Obtener claves primarias del registro seleccionado
            Dim fila As DataGridViewRow = dgvAccesos.SelectedRows(0)
            Dim usuarioId As Integer = CInt(fila.Cells("USUARIO_COD").Value)
            Dim programaId As Integer = CInt(fila.Cells("PROGRAMA_COD").Value)

            ' Obtener los valores actualizados desde los controles
            Dim insertar As Integer = If(cbxCrear.Checked, 1, 0)
            Dim editar As Integer = If(cbxActualizar.Checked, 1, 0)
            Dim borrar As Integer = If(cbxEliminar.Checked, 1, 0)
            Dim buscar As Integer = If(cbxLeer.Checked, 1, 0)

            ' Conexión
            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

            Dim query As String = "UPDATE ACCESOS SET seg_insertar = @insertar, seg_editar = @editar, seg_borrar = @borrar, seg_buscar = @buscar WHERE seg_per_codigo = @usuario AND seg_pro_codigo = @programa"
            Dim comando As New MySqlCommand(query, conexion)

            comando.Parameters.AddWithValue("@insertar", insertar)
            comando.Parameters.AddWithValue("@editar", editar)
            comando.Parameters.AddWithValue("@borrar", borrar)
            comando.Parameters.AddWithValue("@buscar", buscar)
            comando.Parameters.AddWithValue("@usuario", usuarioId)
            comando.Parameters.AddWithValue("@programa", programaId)

            Dim resultado As Integer = comando.ExecuteNonQuery()

            If resultado > 0 Then
                MessageBox.Show("Permisos actualizados correctamente.")
                CargarPermisos() ' Refresca el DataGridView
            Else
                MessageBox.Show("No se pudo actualizar el registro.")
            End If

            conexion.Close()
        Catch ex As Exception
            MessageBox.Show("Error al editar: " & ex.Message)
        End Try
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Try
            If dgvAccesos.SelectedRows.Count = 0 Then
                MessageBox.Show("Selecciona un registro para eliminar.")
                Exit Sub
            End If

            Dim confirmacion = MessageBox.Show("¿Estás seguro que deseas eliminar este acceso?", "Confirmación", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)
            If confirmacion <> DialogResult.Yes Then Exit Sub

            Dim fila As DataGridViewRow = dgvAccesos.SelectedRows(0)
            Dim usuarioId As Integer = CInt(fila.Cells("USUARIO_COD").Value)
            Dim programaId As Integer = CInt(fila.Cells("PROGRAMA_COD").Value)

            Dim conexion As MySqlConnection = ClaseConexion.ObtenerConexion()
            conexion.Open()

            Dim query As String = "DELETE FROM ACCESOS WHERE seg_per_codigo = @usuario AND seg_pro_codigo = @programa"
            Dim comando As New MySqlCommand(query, conexion)

            comando.Parameters.AddWithValue("@usuario", usuarioId)
            comando.Parameters.AddWithValue("@programa", programaId)

            Dim resultado As Integer = comando.ExecuteNonQuery()

            If resultado > 0 Then
                MessageBox.Show("Acceso eliminado correctamente.")
                CargarPermisos() ' Refresca el DataGridView
            Else
                MessageBox.Show("No se pudo eliminar el registro.")
            End If

            conexion.Close()
        Catch ex As Exception
            MessageBox.Show("Error al eliminar: " & ex.Message)
        End Try
    End Sub
End Class
