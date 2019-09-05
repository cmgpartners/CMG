using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for RenewalsView.xaml
    /// </summary>
    public partial class RenewalsView : UserControl
    {
        public ObservableCollection<string> menuItems { get; set; }

        public RenewalsView()
        {
            InitializeComponent();
            this.LoadData();
        }

        public void LoadData()
        {
            int currentYearCount = DateTime.Now.Year - 1950;
            cmbYears.ItemsSource = Enumerable.Range(1950, currentYearCount + 1).ToArray();
            cmbYears.SelectedValue = DateTime.Now.Year;
        }
    }
}
