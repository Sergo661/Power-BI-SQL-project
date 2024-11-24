from pipeline_relational_data.flow import RelationalDataFlow
from pipeline_dimensional_data.flow import DimensionalDataFlow

inst_rel = RelationalDataFlow()
inst_rel.exec()
inst_rel.close_connection()

inst_dim = DimensionalDataFlow()
inst_dim.exec()
inst_dim.close_connection()

