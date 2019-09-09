unit TextoPadrao.Model.DAO.ComandosSQL;

interface

const
  SQL_CONSULTAR_TEXTOPADRAO = 'Select * from TextoPadrao order by codigo';
  SQL_CONSULTAR_TEXTOPADRAO_FILTRO = 'Select * from TextoPadrao where %s order by codigo';
  SQL_INSERT_TEXTOPADRAO = 'INSERT INTO TextoPadrao (Codigo, Descricao, Texto) VALUES (';
  SQL_UPDATE_TEXTOPADRAO = ' UPDATE TextoPadrao set Codigo=%s, Descricao=%s, Texto=%s where ID=%s';
  SQL_CONSULTAR_ULTIMO_CODIGO = 'Select UltimoCodigo from Codigo where Campo=''CdChamadaTexto'' ';
  SQL_ATUALIZAR_ULTIMO_CODIGO = 'UPDATE Codigo SET UltimoCodigo=%s WHERE Campo=''CdChamadaTexto'' ';
  SQL_EXCLUIR_TEXTO_PADRAO = 'DELETE FROM TextoPadrao WHERE ID=%s';

implementation




end.
