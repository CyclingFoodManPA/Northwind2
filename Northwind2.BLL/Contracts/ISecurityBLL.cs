/*****************************************************************************
 *       Interface Name: ISecurityBLL
 * Interface Decription: Contains Interface for the Security business logic
 *                       layer
 *                 Date: Friday, July 1, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Contracts
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.Common.Classes;

    public interface ISecurityBLL
    {
        bool LoginAuthentication(SecurityRequestFields input, ref string message);
        bool ApplicationUserToApplicationRole_IsIn(SecurityRequestFields request, ref string message);
        IList<UserFullNameToRoleNameBDO> UsernameApplicationRoles(SecurityRequestFields request, out int totalCount, ref string message);
    }
}
