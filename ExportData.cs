using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TableMapping
{
    public partial class ExportData : Form
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ToString());

        SqlCommand cmd = new SqlCommand();
        DataTable dt = new DataTable();
        DataTable dtExclData = new DataTable();
        DataTable dtHeader = new DataTable();
        DataTable dtSearchData = new DataTable();
        DataTable dtTagType = new DataTable();
        string TagType = "";
        SqlDataAdapter ad = new SqlDataAdapter();
        public ExportData()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txttaggrp.Text =="")
            {
                MessageBox.Show("Tag Group Id Required");
                return;
            }
            cmd.Connection = con;
            con.Open();
            dt.Clear();
            cmd.CommandText = "select count(*)colcnt from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='FromExcel'";
            cmd.CommandType = CommandType.Text;
            ad.SelectCommand = cmd;
            dt.Clear();
            ad.Fill(dt);
            int colcnt = Convert.ToInt32(dt.Rows[0]["colcnt"]);
            con.Close();

            cmd.Connection = con;
            con.Open();
            dtHeader.Clear();
            cmd.CommandText = "select TOP (1)* from FromExcel";
            cmd.CommandType = CommandType.Text;
            ad.SelectCommand = cmd;
            ad.Fill(dtHeader);
            con.Close();
            string Tblnm = Convert.ToString(dtHeader.Rows[0][0]);

            cmd.Connection = con;
            con.Open();
            dtExclData.Clear();
            cmd.CommandText = "select * from FromExcel except ( select TOP (1)* from FromExcel)";
            cmd.CommandType = CommandType.Text;
            ad.SelectCommand = cmd;
            ad.Fill(dtExclData);
            con.Close();


            for (int i = 0; i < dtExclData.Rows.Count; i++)
            {
                cmd.Connection = con;
                con.Open();
                dtSearchData.Clear();
                cmd.CommandText = "select Fileid from filemaster where FileName='" + dtExclData.Rows[i]["FileNm_Barcd"] + "' ";
                cmd.CommandType = CommandType.Text;
                ad.SelectCommand = cmd;
                ad.Fill(dtSearchData);
                con.Close();
                if (dtSearchData.Rows.Count > 0)
                {

                    for (int j = 2; j <colcnt; j++)
                    {

                        cmd.Connection = con;
                        con.Open();
                        dtTagType.Clear();
                        cmd.CommandText = "select TagType from tagMaster where Tgid=" + txttaggrp.Text + " and  upper(Replace(TagName,' ',''))=Upper(REPLACE('" + dtHeader.Rows[0][j] + "',' ','')) ";
                        cmd.CommandType = CommandType.Text;
                        ad.SelectCommand = cmd;
                        ad.Fill(dtTagType);
                        con.Close();


                        if (dtTagType.Rows.Count > 0)
                        {
                            TagType = Convert.ToString(dtTagType.Rows[0]["TagType"]);
                        }
                        else
                        {
                            TagType = "0";

                        }
                        con.Open();
                        cmd.CommandText = "insert into  " + Tblnm + "  values(" + dtSearchData.Rows[0][0] + ",0,'" + dtHeader.Rows[0][j] + "'," + TagType + ",'" + dtExclData.Rows[i][j] + "',GetDate(),'admin',NULL," + txttaggrp.Text + ")";
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        cmd.ExecuteNonQuery();
                        con.Close();

                    }
                }
                else
                {
                    con.Open();
                    cmd.CommandText = "insert into FileNotFound values(" + dtExclData.Rows[i]["FileNm_Barcd"] + " )";
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                    con.Close();
                   // MessageBox.Show("File Not Found in File Master For File Name =" + dtExclData.Rows[i]["FileNm_Barcd"] + " ", "Alert!!!");
                }
                lblprocess.Text = "Rcords " + i + " inserted";

                Application.DoEvents();
              
            }
            lblprocess.Text = "Rcords  completed";

            Application.DoEvents();
            dt.Clear();
            dtExclData.Clear();
            dtSearchData.Clear();
            dtHeader.Clear();
            dtTagType.Clear();


        }
    }
}
