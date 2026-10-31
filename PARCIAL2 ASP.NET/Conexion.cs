using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PARCIAL2_ASP.NET
{
    public static class Conexion
    {
        public static string CadenaConexion
        {
            get
            {
                if (ConfigurationManager.ConnectionStrings["cnx"] != null)
                {
                    return ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
                }
                return @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True";
            }
        }

        public static SqlConnection ObtenerConexion()
        {
            SqlConnection cn = new SqlConnection(CadenaConexion);
            return cn;
        }

        public static DataTable EjecutarConsulta(string sql, params SqlParameter[] parametros)
        {
            using (SqlConnection cn = ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand(sql, cn))
                {
                    cmd.CommandType = CommandType.Text;
                    if (parametros != null && parametros.Length > 0)
                    {
                        cmd.Parameters.AddRange(parametros);
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static int EjecutarComando(string sql, params SqlParameter[] parametros)
        {
            using (SqlConnection cn = ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand(sql, cn))
                {
                    cmd.CommandType = CommandType.Text;
                    if (parametros != null && parametros.Length > 0)
                    {
                        cmd.Parameters.AddRange(parametros);
                    }
                    cn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object EjecutarEscalar(string sql, params SqlParameter[] parametros)
        {
            using (SqlConnection cn = ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand(sql, cn))
                {
                    cmd.CommandType = CommandType.Text;
                    if (parametros != null && parametros.Length > 0)
                    {
                        cmd.Parameters.AddRange(parametros);
                    }
                    cn.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }
    }
}
