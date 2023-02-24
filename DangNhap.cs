using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanCaPhe
{
    public partial class DangNhap : Form
    {
        public DangNhap()
        {
            InitializeComponent();
        }
        private void btDangNhap_Click(object sender, EventArgs e)
        {
            dangNhap();
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            string message = "Do you want to exit app ?";
            string title = "Close Window";
            MessageBoxButtons buttons = MessageBoxButtons.YesNo;
            DialogResult result = MessageBox.Show(message, title, buttons);
            if (result == DialogResult.Yes)
            {
                this.Close();
            }
        }

        private void dangNhap()
        {
            if (txtMaAdmin.Text == "" || txtMatKhauAdmin.Text != "123" || txtMaAdmin.Text != "AD")
            {
                MessageBox.Show("Sai thông tin đăng nhập!");
                txtMaAdmin.Clear();
                txtMatKhauAdmin.Clear();
                txtMaAdmin.Focus();
            }
            else
            {
                MessageBox.Show("Đăng nhập thành công!");
                Menu menu = new Menu();
                menu.Show();
                this.Hide();
            }
        }
        protected override bool ProcessDialogKey(Keys keyData)
        {
            if (keyData == Keys.Escape)
            {
                Close();
                return true;
            }
            if (keyData == Keys.Enter)
            {
                dangNhap();
                return true;
            }
            return base.ProcessDialogKey(keyData);
        }

        private void DangNhap_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult thoat = MessageBox.Show("Bạn có muốn thoát không?", "Thoát",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (thoat == DialogResult.No)
                e.Cancel = true;
            else
                Application.Exit();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
