import utils
from . import config
from . import tasks
from . import logging_
logger = logging_.setup_logger()

class DimensionalDataFlow:
    def __init__(self):
        self.conn_relational = tasks.connect_db_create_cursor("Database2")
        logging_.log_message(logger,'info', 'Connected to the Database')

    def close_connection(self):
        self.conn_relational.close()
        logging_.log_message(logger,'info', 'Disconnected from the Database')

    def exec(self):
        logging_.log_message(logger,'info', 'Start of Dimensional Database Update')

        # Ingesting with order (taking into account pk,fk-s)
        logging_.log_message(logger,'info', 'Updating DimEmployees')
        tasks.update_dim_Categories(self.conn_relational, 'DimCategories_SCD1_with_delete', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimCustomers')
        tasks.update_dim_Customers(self.conn_relational, 'DimCustomers_SCD4_1', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimEmployees')
        tasks.update_dim_Employees(self.conn_relational, 'DimEmployees_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimSuppliers')
        tasks.update_dim_Suppliers(self.conn_relational, 'DimSuppliers_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimShippers')
        tasks.update_dim_Shippers(self.conn_relational, 'DimShippers_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimRegion')
        tasks.update_dim_Region(self.conn_relational, 'DimRegion_SCD2', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimProducts')
        tasks.update_dim_Products(self.conn_relational, 'DimProducts_SCD4_1', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating DimTerritories')
        tasks.update_dim_Territories(self.conn_relational, 'DimTerritories_SCD2', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'Updating FactOrders')
        tasks.update_fact_FactOrders(self.conn_relational, 'FactOrders', 'ORDERS_DIMENSIONAL_DB', 'dbo')

        logging_.log_message(logger,'info', 'End of the Dimensional Database Update')