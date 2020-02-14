using CMG.UI.Controls;
using System.Windows;
using System.Windows.Controls;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for FYCView.xaml
    /// </summary>
    public partial class FYCView : UserControl
    {
        public FYCView()
        {
            InitializeComponent();
        }

        private void UserControlPolicyNumber_GotFocus(object sender, RoutedEventArgs e)
        {
            var autoCompleteBox = (AutoCompleteBox)sender;
            Style textBoxStyle = new Style();
            autoCompleteBox.autoTextBox.Style = FindResource("CommissionGridTextBoxStyle") as Style;
        }
    }
}
