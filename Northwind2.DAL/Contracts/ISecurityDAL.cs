/*****************************************************************************
 *       Interface Name: ISecurityDAL
 * Interface Decription: Contains Interface for Security data access layer
 *                 Date: Friday, July 1, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using Northwind2.BDO;
using Northwind2.Common.Classes;

namespace Northwind2.DAL.Contracts
{
    public interface ISecurityDAL
    {
        bool LoginAuthentication(SecurityRequestFields input, ref string message);
        bool ApplicationUserToApplicationRole_IsIn(SecurityRequestFields request, ref string message);
        IList<UserFullNameToRoleNameBDO> UsernameApplicationRoles(SecurityRequestFields request, out int totalCount, ref string message);
    }
}
