/*****************************************************************************
 *        Class Name: UserFullNameToRoleNameManualConverter
 *  Class Decription: Contains the converter for the ContactTitle entity
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.BDO;
using Northwind2.Entities.Models;
using Northwind2.ServiceWcf.Converters.Infrastructure;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Converters
{
    public class UserFullNameToRoleNameManualConverter : BaseConverter<UserFullNameToRoleNameBDO, UserFullNameToRoleNameSDO>
    {
        public override UserFullNameToRoleNameSDO ConvertObject(UserFullNameToRoleNameBDO bdo)
        {
            //Manual one-to-one mapping
            return new UserFullNameToRoleNameSDO()
            {
                ApplicationUserID = bdo.ApplicationUserID,
                ApplicationUserLastName = bdo.ApplicationUserLastName,
                ApplicationUserFirstName = bdo.ApplicationUserFirstName,
                Username = bdo.Username,
                ApplicationRoleID = bdo.ApplicationRoleID,
                ApplicationRoleName = bdo.ApplicationRoleName
            };
        }
    }
}
