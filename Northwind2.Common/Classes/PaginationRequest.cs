/*****************************************************************************
 *        Class Name: PaginationRequest
 *  Class Decription: Contains pagination and sorting parameters for entities.
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Common.Classes
{
	public enum SortDirection
	{
		Ascending,
		Descending
	}

	public class PaginationRequest
	{
		public int PageIndex { get; set; }
		public int PageSize { get; set; }
		public Sort Sort { get; set; }
		public PaginationRequest()
		{
			this.Sort = new Sort();
		}
	}

	public class Sort
	{
		public string SortBy { get; set; }
		public SortDirection SortDirection { get; set; }
	}
}
