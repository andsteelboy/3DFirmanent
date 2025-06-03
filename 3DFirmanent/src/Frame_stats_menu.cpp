#include "Frame_stats_menu.h"

Frame_Stats_Menu::Frame_Stats_Menu()
{
	frameTime=0.0f;
	delta=0.0f;
	CPUTime=0.0f;
	GPUTime=0.0f;
	DrawCalls = 0.0f;
}

Frame_Stats_Menu::~Frame_Stats_Menu()
{
}

void Frame_Stats_Menu::RenderStatsOverlay()
{
}
