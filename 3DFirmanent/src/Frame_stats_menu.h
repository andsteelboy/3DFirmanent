#pragma once
class Frame_Stats_Menu {
public:
	Frame_Stats_Menu();
	~Frame_Stats_Menu();
	void RenderStatsOverlay();
private:
	float frameTime;
	float delta;
	float CPUTime;
	float GPUTime;
	float DrawCalls;
};
