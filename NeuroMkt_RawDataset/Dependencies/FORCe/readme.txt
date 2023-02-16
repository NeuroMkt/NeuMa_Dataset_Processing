FORCe: Fully Online and automated artifact Removal for brain-Computer interfacing

FORCe attempts to perform fully automated EEG artifact removal for brain-computer interfaces (BCIs). It is able to remove blinks, ECG, movement, and a large amount of EMG artifact from the EEG very quickly. Therefore, it can be used during online BCI. FORCe operates by first taking a Wavelet decomposition of a short window of the EEG and then applying a combination of soft and hard thresholding to the detail coefficients of the decompositions. The approximation coefficients are further processed by independent component analysis and combinations of various statistical thresholds are used to automatically identify components which contain artifacts are remove them.

Further details of the operation of the FORCe method can be found in the paper. Which may be obtained here
http://www.ncbi.nlm.nih.gov/pubmed/25134085

If you don’t have access to the above link a pre-print (authors self-archive) version of the paper can be found here
http://www.iandaly.co.uk/FORCe%20fully%20online%20and%20automated%20artifact%20removal%20for%20brain-computer%20interfacing.pdf.

The code can be downloaded from 
https://bci.tugraz.at/research/software

=== References ===
Please cite the following paper when using FORCe, or a modified version of FORCe, in your research.

Daly, I. et al., 2014. FORCe: Fully Online and automated artifact Removal for brain-Computer interfacing. IEEE transactions on neural systems and rehabilitation engineering?: a publication of the IEEE Engineering in Medicine and Biology Society. Available at: http://www.ncbi.nlm.nih.gov/pubmed/25134085

It is recommended to also acknowledge the authors of second order blind independent component analysis (SOBI) when using FORCe in your research.
Belouchrani, A. et al., 1997. A blind source separation technique using second-order statistics. IEEE Transactions on Signal Processing, 45(2), pp.434–444.


=== Requirements ===
FORCe runs in Matlab and requires the Matlab Wavelet toolbox to run. It and does not rely on any other external toolboxes  for its operation. However, it does make use of EEGlab formatted channel location files. EEGlab can be obtained here (http://sccn.ucsd.edu/eeglab/) (external website).

Additionally, FORCe uses second order blind independent component analysis (SOBI). The method is adapted from code available here (http://sccn.ucsd.edu/eeglab/allfunctions/sobi.html). It is recommended to also acknowledge the authors of SOBI when using FORCe in your research.


=== License and legal stuff ===
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

