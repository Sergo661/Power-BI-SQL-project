from pipeline_dimensional_data.flow import DimensionalDataFlow

inst = DimensionalDataFlow()
inst.exec()
inst.close_connection()