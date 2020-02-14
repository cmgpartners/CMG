using CMG.UI.Controls;
using System.Windows;
using System.Windows.Controls;

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

        private void UserControlPolicyNumber_GotFocus(object sender, RoutedEventArgs e)
        {
            var autoCompleteBox = (AutoCompleteBox)sender;
            Style textBoxStyle = new Style();
            autoCompleteBox.autoTextBox.Style = FindResource("CommissionGridTextBoxStyle") as Style;
        }
    }
}
