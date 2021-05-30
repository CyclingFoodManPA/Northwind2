/*****************************************************************************
 *        Class Name: RepositoryBase
 *  Class Decription: Contains repository base elements in the Northwind2 System.
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *             Notes: based on:
 *                    MyFinance MVC 3, EF, etc.: http://efmvc.codeplex.com/
 *                    ContosoUniversity MVC 3, EF, etc.:http://www.asp.net/entity-framework/tutorials/creating-an-entity-framework-data-model-for-an-asp-net-mvc-application                    
 *                    ObjectContext vs DbContext: http://www.entityframeworktutorial.net/EntityFramework4.3/dbcontext-vs-objectcontext.aspx
 *                    Improvements and Ehnancements of Data Access Web Service Using Wcf and Entity Framework:
 *                    http://www.codeproject.com/Articles/685336/Improvements-and-Enhancements-of-a-Data-Access-Web?msg=4787150#xx4787150xx
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using log4net;
using Northwind2.Repositories.Contracts;

namespace Northwind2.Repositories.Implementation
{
    public class RepositoryBase<TEntity> : Northwind2Repositories, IRepositoryBase<TEntity> where TEntity : class
    {
        // Private Member Variables
        private const string THIS_CLASS = "RepositoryBase";

        public IUnitOfWork UnitOfWork { get; set; }

        // Public Constructor
        public RepositoryBase(IUnitOfWork unitOfWork)
        {
            if (unitOfWork == null)
            {
                throw new ArgumentException("Northwind2UnitOfWork");
            }

            // Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();

            // Get logger
            _log = LogManager.GetLogger(typeof(RepositoryBase<TEntity>));

            // Start logging
            _log.Info(THIS_CLASS + ": ConstruPublic Constructor Call");

            this.UnitOfWork = unitOfWork;
        }

        private IDbSet<TEntity> _objectset;
        internal IDbSet<TEntity> DbSet
        {
            get
            {
                if (_objectset == null)
                {
                    _objectset = this.UnitOfWork.Context.Set<TEntity>();
                }
                return _objectset;
            }
        }

        #region IRepository<TEntity> Members

        public virtual object Add(TEntity entity)
        {
            _log.Info(THIS_CLASS + ": Add(TEntity entity)");

            return this.DbSet.Add(entity);
        }

        public virtual TEntity GetByID(object id)
        {
            _log.Info(THIS_CLASS + ": GetByID; id = " + id.ToString().Trim());

            return this.DbSet.Find(id);
        }

        public virtual IList<TEntity> GetAll()
        {
            _log.Info(THIS_CLASS + ": GetAll");

            return this.DbSet.ToList();
        }

        public virtual IEnumerable<TEntity> Get(
            Expression<Func<TEntity, bool>> filter = null,
            Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>> orderBy = null,
            string includeProperties = "")
        {
            _log.Info(THIS_CLASS + ": Get");

            IQueryable<TEntity> query = DbSet;

            if (filter != null)
            {
                query = query.Where(filter);
            }

            foreach (var includeProperty in includeProperties.Split
                (new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
            {

                query = query.Include(includeProperty);
            }

            if (orderBy != null)
            {
                return orderBy(query).ToList();
            }
            else
            {
                return query.ToList();
            }
        }

        public virtual IQueryable<TEntity> GetIQueryable()
        {
            _log.Info(THIS_CLASS + ": GetIQueryable<TEntity>");

            return this.DbSet.AsQueryable<TEntity>();
        }

        public virtual IList<TEntity> GetAllPaged(int pageIndex, int pageSize, out int totalCount)
        {
            _log.Info(THIS_CLASS + ": IList<TEntity> GetAllPaged; PageIndex = " + pageIndex.ToString().Trim() +
                "PageSize = " + pageSize.ToString().Trim());

            totalCount = this.DbSet.Count();
            return this.DbSet.Skip(pageSize * pageIndex).Take(pageSize).ToList();
        }

        public virtual void Update(TEntity entity)
        {
            _log.Info(THIS_CLASS + ": Update(TEntity)");

            this.DbSet.Attach(entity);
            this.UnitOfWork.Context.Entry(entity).State = System.Data.Entity.EntityState.Modified;
        }

        public virtual void Delete(object id)
        {
            _log.Info(THIS_CLASS + ": Delete; ID = " + id.ToString().Trim());

            this.DbSet.Remove(GetByID(id));
        }

        public virtual void Delete(TEntity entity)
        {
            _log.Info(THIS_CLASS + ": Delete(TEntity)");

            this.DbSet.Attach(entity);
            this.DbSet.Remove(entity);
        }

        public virtual void CommitAllChanges()
        {
            this.UnitOfWork.Commit();
        }

        #endregion
    }
}
