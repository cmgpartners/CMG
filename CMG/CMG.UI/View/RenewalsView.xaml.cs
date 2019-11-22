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
        public RenewalsView()
        {
            InitializeComponent();
        }

        private void ButtonAdd_Click(object sender, RoutedEventArgs e)
        {
            if (renewals.Items.Count > 1)
            {
                var lastRowItem = renewals.Items[renewals.Items.Count - 1];
                renewals.ScrollIntoView(lastRowItem);
            }
        }
    }
}
