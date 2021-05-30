/*****************************************************************************
 *        Class Name: ExceptionHelpers
 *  Class Decription: Contains helper classes for Exceptions
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Text;

namespace Northwind2.Common.Infrastructure
{
    public static class ExceptionHelpers
    {
        public static string GetAllMessages(this Exception ex)
        {
            if (ex == null)
                throw new ArgumentNullException("ex");

            string s = string.Empty;
            while (ex != null)
            {
                if (!string.IsNullOrEmpty(ex.Message))
                {
                    s = ex.Message;
                }

                ex = ex.InnerException;
            }

            return s;
        }
    }
}