/*****************************************************************************
 *        Class Name: GridViewModelBase
 *  Class Decription: Base class for all lists of entities
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using Northwind2.Common.Constants;

namespace Northwind2.Mvc3UI.ViewModels
{
    public abstract class GridViewModelBase
    {
        #region Public Constructor

        public GridViewModelBase()
        {
            // Define any default values here...
            this.PageSize = Constants.PAGE_SIZE;
            this.NumericPageCount = Constants.PAGE_SIZE;
        }

        #endregion Public Constructor

        #region Sorting Related Properties

        // Sorting-related properties
        public string SortBy { get; set; }
        public bool SortAscending { get; set; }
        public string SortExpression
        {
            get { return this.SortAscending ? this.SortBy + " asc" : this.SortBy + " desc"; }
        }

        #endregion Sorting Related Properties

        #region Paging Related Properties

        // Paging-related properties
        // the page index currently being viewed
        public int CurrentPageIndex { get; set; }

        // the number of records to show per page of data
        public int PageSize { get; set; }

        // the total number of records being paged through
        public int TotalRecordCount { get; set; }

        // the number of pages of data
        public int PageCount
        {
            get
            {
                return (this.TotalRecordCount <= this.PageSize)
                  ? Math.Max(this.TotalRecordCount / this.PageSize, 1)
                  : Math.Max(this.TotalRecordCount / this.PageSize, 1) + 1;
            }
        }

        // how many numeric page buttons to show in the grid's paging properties
        public int NumericPageCount { get; set; }

        #endregion Paging Related Properties
    }
}