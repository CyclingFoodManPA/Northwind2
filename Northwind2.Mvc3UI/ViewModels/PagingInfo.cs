/*****************************************************************************
 *        Class Name: PagingInfo
 *  Class Decription: Class used to control paging of list items in application
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;

namespace Northwind2.Mvc3UI.ViewModels
{
	public class PagingInfo
	{
		#region Public Variables

		public int TotalItems { get; set; }
		public int ItemsPerPage { get; set; }
		public int CurrentPage { get; set; }

		#endregion Public Variables

		#region Public Methods

		public int TotalPages
		{
			get { return (int)Math.Ceiling((decimal)TotalItems / ItemsPerPage); }
		}

		#endregion Public Methods
	}
}