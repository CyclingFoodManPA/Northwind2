/*****************************************************************************
 *        Class Name: ListViewModelBase
 *  Class Decription: Base class for all lists of entities
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;

namespace Northwind2.Mvc3UI.ViewModels
{
	public abstract class ListViewModelBase<TEntity> where TEntity : class
	{
		public IEnumerable<TEntity> ObjectCollection { get; set; }
		public PagingInfo PagingInfo { get; set; }
	}
}
