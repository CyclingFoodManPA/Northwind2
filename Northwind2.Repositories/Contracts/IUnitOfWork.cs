/*****************************************************************************
 *       Interface Name: INorthwind2UnitOfWork
 * Interface Decription: Contains Interface for the UnitOfWork
 *                 Date: Friday, July 1, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using Northwind2.Context;

namespace Northwind2.Repositories.Contracts
{
    public interface IUnitOfWork : IDisposable
    {
        Northwind2Context Context { get; set; }
        void Commit();
        bool LazyLoadingEnabled { get; set; }
    }
}
