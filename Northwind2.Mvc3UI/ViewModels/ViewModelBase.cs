/*****************************************************************************
 *        Class Name: ViewModelBase
 *  Class Decription: Base class for all entities
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Northwind2.Mvc3UI.ViewModels
{
    public abstract class ViewModelBase
    {
        #region Primitive Properties

        [HiddenInput(DisplayValue = false)]
        public string AddedBy { get; set; }

        [HiddenInput(DisplayValue = false)]
        public DateTime AddedDate { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string ModifiedBy { get; set; }

        [HiddenInput(DisplayValue = false)]
        public DateTime ModifiedDate { get; set; }

        [ConcurrencyCheck]
        [Timestamp]
        public Byte[] Modified { get; set; }

        #endregion Primitive Properties
    }
}