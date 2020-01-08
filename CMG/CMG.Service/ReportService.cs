using CMG.DataAccess.Domain;
using CMG.Service.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace CMG.Service
{
    //This service should contain only short methods for different reports (detail logic should go in separate files and call those file from these functions)
    public class ReportService : IReportService
    {
        private SqlConnection _sqlConnection;
        public ReportService(pb2Context context)
        {
            _sqlConnection = (SqlConnection)context.Database.GetDbConnection();
        }

        //created sample methods for sql connection and execute query (Need to create baseclass file and move this common methods to that file)
        private SqlConnection GetConnection()
        {
            if (_sqlConnection.State != ConnectionState.Open)
                _sqlConnection.Open();
            return _sqlConnection;
        }

        protected DbCommand GetCommand(DbConnection connection, string commandText, CommandType commandType)
        {
            SqlCommand command = new SqlCommand(commandText, connection as SqlConnection);
            command.CommandType = commandType;
            return command;
        }

        protected int ExecuteNonQuery(string procedureName, List<DbParameter> parameters, CommandType commandType = CommandType.StoredProcedure)
        {
            int returnValue = -1;

            try
            {
                using (SqlConnection connection = this.GetConnection())
                {
                    DbCommand cmd = this.GetCommand(connection, procedureName, commandType);

                    if (parameters != null && parameters.Count > 0)
                    {
                        cmd.Parameters.AddRange(parameters.ToArray());
                    }

                    returnValue = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                //LogException("Failed to ExecuteNonQuery for " + procedureName, ex, parameters);
                throw;
            }

            return returnValue;
        }
    }
}
