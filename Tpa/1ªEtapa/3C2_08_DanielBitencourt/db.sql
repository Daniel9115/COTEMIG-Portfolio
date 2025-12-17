DROP DATABASE IF EXISTS tpa_e1_pf; CREATE DATABASE IF NOT EXISTS tpa_e1_pf; USE tpa_e1_pf;
CREATE TABLE IF NOT EXISTS vagas_emprego ( id INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(100) NOT NULL, senioridade VARCHAR(50) NOT NULL, descricao TEXT );
INSERT INTO vagas_emprego (nome, senioridade, descricao) VALUES ('Desenvolvedor(a) Front-end', 'Pleno', 'Experiência com React e Angular'), ('Desenvolvedor(a) Back-end', 'Sênior', 'Conhecimento em PHP e Node.js'), ('Analista de Dados', 'Júnior', 'Habilidade com SQL e Python');
