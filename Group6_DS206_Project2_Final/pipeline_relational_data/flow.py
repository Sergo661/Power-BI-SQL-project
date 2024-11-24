import utils
from . import config
from . import tasks
from . import logging_
logger = logging_.setup_logger()

class RelationalDataFlow:
    def __init__(self):
        self.conn_relational = tasks.connect_db_create_cursor("Database1")
        logging_.log_message(logger,'info', 'Connected to the Database')

    def close_connection(self):
        self.conn_relational.close()
        logging_.log_message(logger,'info', 'Disconnected from the Database')

    def exec(self):
        logging_.log_message(logger,'info', 'Starting data insertion flow')

        # Ingesting with order (taking into account pk,fk-s)
        logging_.log_message(logger,'info', 'Inserting into Categories')
        tasks.insert_into_Categories(self.conn_relational, 'Categories', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Customers')
        tasks.insert_into_Customers(self.conn_relational, 'Customers', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Employees')
        tasks.insert_into_Employees(self.conn_relational, 'Employees', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Suppliers')
        tasks.insert_into_Suppliers(self.conn_relational, 'Suppliers', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Shippers')
        tasks.insert_into_Shippers(self.conn_relational, 'Shippers', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Region')
        tasks.insert_into_Region(self.conn_relational, 'Region', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Products')
        tasks.insert_into_Products(self.conn_relational, 'Products', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Territories')
        tasks.insert_into_Territories(self.conn_relational, 'Territories', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into Orders')
        tasks.insert_into_Orders(self.conn_relational, 'Orders', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Inserting into OrderDetails')
        tasks.insert_into_OrderDetails(self.conn_relational, 'OrderDetails', 'ORDERS_RELATIONAL_DB', 'dbo', config.data_dir)

        logging_.log_message(logger,'info', 'Finish of the data Insertion')