from pipeline_relational_data.flow import RelationalDataFlow

inst = RelationalDataFlow()
inst.exec()
inst.close_connection()