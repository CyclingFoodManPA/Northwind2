/*****************************************************************************
 *       Interface Name: IRepositoryBase
 * Interface Decription: Contains Interface for the RepositoryBase
 *                 Date: Friday, July 1, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Northwind2.Repositories.Contracts
{
    public interface IRepositoryBase<TEntity> where TEntity : class
    {
        // Create
        object Add(TEntity entity);

        // Read
        TEntity GetByID(object id);
        IList<TEntity> GetAll();
        IList<TEntity> GetAllPaged(int pageNumber, int pageSize, out int totalCount);
        IEnumerable<TEntity> Get(Expression<Func<TEntity, bool>> filter = null, 
            Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>> orderBy = null, 
            string includeProperties = "");

        // Update
        void Update(TEntity entity);

        // Delete
        void Delete(object id);
        void Delete(TEntity entity);
        
        // Transactional
        void CommitAllChanges();
    }
}
