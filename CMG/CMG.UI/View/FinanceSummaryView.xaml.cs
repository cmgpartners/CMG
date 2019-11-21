using System;
using System.Collections.Generic;
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
    /// Interaction logic for FinanceSummaryView.xaml
    /// </summary>
    public partial class FinanceSummaryView : UserControl
    {
        #region MemberVariables
        private const string NotEntered = "Not Entered";
        private const string Entered = " Entered";
        #endregion MemberVariables

        public FinanceSummaryView()
        {
            InitializeComponent();
        }

        private void CheckBox_Checked(object sender, RoutedEventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            Label lbl = (Label)chk.Content;
            lbl.Content = NotEntered;
            if (chk.IsChecked ?? false)
            {
                lbl.Content = Entered;
            }
        }

        private void CheckBox_Unchecked(object sender, RoutedEventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            Label lbl = (Label)chk.Content;
            lbl.Content = Entered;
            if (!chk.IsChecked ?? false)
            {
                lbl.Content = NotEntered;
            }
        }
    }
}
