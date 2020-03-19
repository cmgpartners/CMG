using System;
using System.ComponentModel;
using System.Threading;
using System.Windows;
using System.Windows.Input;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for ProgressbarView.xaml
    /// </summary>
    public partial class ProgressbarWindow : Window
    {
        public ProgressbarWindow()
        {
            InitializeComponent();
        }
        private void Window_ContentRendered(object sender, EventArgs e)
        {
            BackgroundWorker worker = new BackgroundWorker();
            worker.WorkerReportsProgress = true;
            worker.DoWork += worker_DoWork;
            worker.ProgressChanged += worker_ProgressChanged;
            worker.RunWorkerCompleted += Worker_RunWorkerCompleted;

            worker.RunWorkerAsync();
        }

        private void Worker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            pbStatus.Value = 100;            
            App app = (App)System.Windows.Application.Current;
            if (app.mainWindow != null)
            {
                ((Window)app.mainWindow).Show();
            }
            this.Hide();
            Mouse.OverrideCursor = System.Windows.Input.Cursors.Arrow;
        }

        void worker_DoWork(object sender, DoWorkEventArgs e)
        {
            for (int i = 0; i < 100; i++)
            {
                (sender as BackgroundWorker).ReportProgress(i);
                Thread.Sleep(3);
            }
        }
        void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            pbStatus.Value = e.ProgressPercentage;
        }
    }
}
